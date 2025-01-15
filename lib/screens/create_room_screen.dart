import 'package:flutter/material.dart';
import 'package:scribble_guesser_app/screens/paint_screen.dart';
import 'package:scribble_guesser_app/widgets/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();
  late String? _maxRoundsValue;
  late String? _roomSizeValue;


  void createRoom(){
    if(_nameController.text.isNotEmpty && _roomNameController.text.isNotEmpty && _maxRoundsValue != null &&_roomSizeValue != null){
      Map<String, String> data = {
        "nickname": _nameController.text,
        "roomName" : _roomNameController.text,
        "occupancy": _roomSizeValue!,
        "maxRounds": _maxRoundsValue!,
      };
      print( "data-" + data.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => PaintScreen(data: data, screenFrom: "createRoom"),),);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "create room",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: CustomTextField(
              Controller: _nameController,
              hint: "Enter your name",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: CustomTextField(
              Controller: _roomNameController,
              hint: "Enter room name",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButton<String>(
            focusColor: Color(0xffF5F6FA),
            items: ["2", "5", "10", "15"]
                .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
                .toList(),
            hint: Text(
              "select max rounds",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            onChanged: (String? value) {
              setState(() {
                _maxRoundsValue = value;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButton<String>(
            focusColor: Color(0xffF5F6FA),
            items: ["2", "3", "4", "5", "6", "7", "8"]
                .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
                .toList(),
            hint: Text(
              "select room size",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            onChanged: (String? value) {
              setState(() {
                _roomSizeValue = value;
              });
            },
          ),
          SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.sizeOf(context).width / 2.5, 50),
              backgroundColor: Colors.blue,
              textStyle: TextStyle(color: Colors.white),
            ),
            onPressed: createRoom,
            child: Text(
              "create",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
