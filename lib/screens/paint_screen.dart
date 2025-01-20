import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scribble_guesser_app/models/my_custom_painter.dart';
import 'package:scribble_guesser_app/models/touchpoints.dart';
import 'package:socket_io_client/socket_io_client.dart'
    as io; //importing socket_io_client

class PaintScreen extends StatefulWidget {
  final Map<String, String> data;
  final String screenFrom;

  PaintScreen({required this.data, required this.screenFrom});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  late io.Socket _socket; //
  Map dataOfRoom = {};
  List<Touchpoints> points = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  //socket io client connection
  void connect() {
    _socket = io.io('http://192.168.64.127:8000', <String, dynamic>{
      'transports': ['websocket'],
      'autoconnect': false
    });

    _socket.connect();

    if (widget.screenFrom == "createRoom") {
      _socket.emit('create-game', widget.data);
    } else {
      _socket.emit('join-game', widget.data);
    }

    _socket.onConnect(
      (data) {
        _socket.on(
          'updateRoom',
          (roomData) {
            setState(
              () {
                dataOfRoom = roomData;
              },
            );
            if (roomData['isJoin'] != true) {
              //start
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height * 0.55,
                child: GestureDetector(
                  onPanUpdate: (details) {},
                  onPanStart: (details) {
                 
                  }, 
                  onPanEnd: (details) {},
                  child: SizedBox.expand(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: RepaintBoundary(
                        child: CustomPaint(
                          size: Size.infinite,
                          painter: MyCustomPainter(pointslist: points),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
