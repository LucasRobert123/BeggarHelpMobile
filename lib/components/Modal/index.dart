import 'package:beggarhelp/components/Button/index.dart';
import 'package:flutter/material.dart';

class Modal {
  static void showAlertDialog(BuildContext context, Widget widget) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: FittedBox(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  widget,
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Button(
                      width: MediaQuery.of(context).size.width,
                      heigth: 50,
                      widget: Text(
                        'FECHAR',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      onPress: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
