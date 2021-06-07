import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final String name;

  CustomTabBar({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(8),
      color: Color(0xFF31CF2B),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_circle,
                size: 36,
                color: Colors.white,
              ),
              Padding(
                child: Text(
                  '$name',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                padding: EdgeInsets.only(left: 5),
              ),
            ],
          ),
          IconButton(
              icon: Icon(
                Icons.power_settings_new,
                size: 36,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              })
        ],
      ),
    );
  }
}
