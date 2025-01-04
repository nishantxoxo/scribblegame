import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController Controller;
  String hint;
  CustomTextField({super.key, required this.Controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: Controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: Color(0xffF5F6FA),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)
      ),
    );
  }
}
