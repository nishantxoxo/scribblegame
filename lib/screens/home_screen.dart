import 'package:flutter/material.dart';

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

          SizedBox(height: MediaQuery.sizeOf(context).height*0.1,),

          Row(
            children: [
              ElevatedButton(onPressed: (){}, child: Text("Create", style: TextStyle(color: Colors.black),)),
              ElevatedButton(onPressed: (){}, child: Text("Join", style: TextStyle(color: Colors.black),))

            ],
          )
        ],
      ),
    );
  }
}
