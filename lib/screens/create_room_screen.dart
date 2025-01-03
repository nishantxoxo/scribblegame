import 'package:flutter/material.dart';
import 'package:scribble_guesser_app/widgets/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();

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
            onChanged: (){},
          )
        ],
      ),
    );
  }
}
