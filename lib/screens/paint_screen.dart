import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;  //importing socket_io_client
class PaintScreen extends StatefulWidget {

  final Map<String, String> data;
  final String screenFrom;

   PaintScreen({required this.data,required this.screenFrom});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {

  late io.Socket _socket;                             //
  String dataOfRoom = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }
  //socket io client connection
  void connect(){
    _socket = io.io('http://192.168.64.127:8000',
     <String, dynamic>{
      'transports': ['websocket'],
      'autoconnect': false
    }
    );
  
    _socket.connect();
 
    if(widget.screenFrom == "createRoom"){
      _socket.emit('create-game', widget.data);
    }
    else{
      _socket.emit('join-game', widget.data);
    }

  
    _socket.onConnect((data) {

      _socket.on('updateRoom', (roomData) {
        setState(() {
        dataOfRoom = roomData;
          
        },);
        if(roomData['isJoin'] != true){
          //start

        }

      },);
    },);                
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}