import 'dart:ui';

import 'package:beggarhelp/components/Button/index.dart';
import 'package:flutter/material.dart';

class CardUser extends StatelessWidget {
  String type, text, name;
  Function onPress, onRemove, onDetails;
  CardUser({
    Key key,
    this.type,
    this.text,
    this.name,
    this.onDetails,
    this.onPress,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0xFF31CF2B), width: 1),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    '$name',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFF31CF2B),
                    ),
                  ),
                ),
                Row(
                  children: [
                    onRemove != null
                        ? SizedBox(
                            width: 25,
                            height: 23,
                            child: Transform.scale(
                              scale: 2,
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  size: 12,
                                  color: Color(0xFF31CF2B),
                                ),
                                onPressed: onRemove,
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      width: 25,
                      height: 23,
                      child: Transform.scale(
                        scale: 2,
                        child: IconButton(
                          icon: Icon(
                            Icons.add_circle_sharp,
                            size: 12,
                            color: Color(0xFFFFE34D),
                          ),
                          onPressed: onDetails,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: 8,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: Transform.scale(
                      scale: 2,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.place,
                          color: Color(0xFF31CF2B),
                          size: 12,
                        ),
                        onPressed: null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        '$text',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF31CF2B),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(top: 5),
                child: Button(
                  width: MediaQuery.of(context).size.width * 0.6,
                  widget: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          'Entrar em contato',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  onPress: onPress,
                ))
          ],
        ),
      ),
    );
  }
}
