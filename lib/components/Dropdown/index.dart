import 'package:flutter/material.dart';

class Dropdown extends StatelessWidget {
  final String text, error;
  final TextEditingController controller;
  final List<String> options;

  Dropdown({Key key, this.text, this.error, this.options, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: DropdownButtonFormField(
        iconEnabledColor: Color(0xFF31CF2B),
        items: options.map((String category) {
          return new DropdownMenuItem(
              value: category,
              child: Row(
                children: <Widget>[
                  Text(
                    category,
                    style: TextStyle(
                      color: Color(0xFF31CF2B),
                    ),
                  ),
                ],
              ));
        }).toList(),
        onChanged: (newValue) {
          // do other stuff with _category
          controller.text = newValue;
        },
        value: controller.text == '' ? options[0] : controller.text,
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
      ),
    );
  }
}
