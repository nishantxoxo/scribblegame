import 'package:flutter/material.dart';
import 'package:scribble_guesser_app/screens/create_room_screen.dart';
import 'package:scribble_guesser_app/screens/join_room_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Create/ Join a room to play",
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.sizeOf(context).width / 2.5, 50),
                  backgroundColor: Colors.blue,
                  textStyle: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateRoomScreen(),
                  ),
                ),
                child: Text(
                  "Create",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.sizeOf(context).width / 2.5, 50),
                  backgroundColor: Colors.blue,
                  textStyle: TextStyle(color: Colors.white),
                
                ),
                onPressed: ()=> Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JoinRoomScreen(),
                  ),
                ),
                child: Text(
                  "Join",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
