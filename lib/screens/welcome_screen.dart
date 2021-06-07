import 'package:beggarhelp/components/Button/index.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Image(image: AssetImage('lib/assets/images/logo.png')),
            ),
            Text(
              "CADASTRADO com sucesso!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 40,
                color: Color(0xFF31CF2B),
              ),
            ),
            Button(
                width: MediaQuery.of(context).size.width,
                heigth: 50,
                widget: Text(
                  'FINALIZAR',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                onPress: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                }),
          ],
        ),
      ),
    );
  }
}
