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
  StrokeCap strokeType = StrokeCap.round;
  Color selectedColor = Colors.black;
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
        _socket.on('points', (point) {
          if (point['details'] != null) {
            setState(() {
              points.add(Touchpoints(
                  points: Offset(
                      (point['details']['dx']), (point['details']['dy'])),
                  paint: Paint()..strokeCap = strokeType..isAntiAlias = true..color = selectedColor, 
                ));
            });
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
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
                  onPanUpdate: (details) {
                    print(details.localPosition.dx);
                    _socket.emit('paint', {
                      'details': {
                        'dx': details.localPosition.dx,
                        'dy': details.localPosition.dy,
                      },
                      'roomName': widget.data['name'],
                    });
                  },
                  onPanStart: (details) {
                    print(details.localPosition.dx);
                    _socket.emit('paint', {
                      'details': {
                        'dx': details.localPosition.dx,
                        'dy': details.localPosition.dy,
                      },
                      'roomName': widget.data['name'],
                    });
                  },
                  onPanEnd: (details) {
                    print(details.localPosition.dx);
                    _socket.emit('paint', {
                      'details': null,
                      'roomName': widget.data['name'],
                    });
                  },
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
