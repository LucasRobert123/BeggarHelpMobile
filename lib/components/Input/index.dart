import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String text, error;
  final TextEditingController controller;
  Input({this.text, this.error, this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4, bottom: 4),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          controller: controller,
          cursorColor: Color(0xFF31CF2B),
          decoration: InputDecoration(
            labelText: text,
            errorText: error,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF31CF2B)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF31CF2B)),
            ),
            labelStyle: TextStyle(
              color: Color(0xFF31CF2B),
            ),
          ),
          style: TextStyle(
            color: Color(0xFF31CF2B),
          ),
        ),
      ),
    );
  }
}
