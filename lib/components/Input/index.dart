import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String text, error;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function validator;
  Input(
      {this.text,
      this.error,
      this.controller,
      this.obscureText,
      this.keyboardType,
      this.validator});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4, bottom: 4),
      child: Container(
        child: TextFormField(
          controller: controller,
          cursorColor: Color(0xFF31CF2B),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
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
          obscureText: obscureText == null ? false : obscureText,
          keyboardType: keyboardType,
          style: TextStyle(
            color: Color(0xFF31CF2B),
          ),
          validator: (value) => validator(value),
        ),
      ),
    );
  }
}
