import 'package:beggarhelp/components/CustomTabBar/index.dart';
import 'package:flutter/material.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({Key key}) : super(key: key);

  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomTabBar(
              name: 'Lucas',
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [],
              ),
            )
            // CardUser(
            //   name: 'Lucas',
            //   text: 'Rua José Augusto,174',
            //   onPress: () {},
            //   onDetails: () {},
            //   onRemove: () {},
            // )
          ],
        ),
      ),
    );
  }
}
