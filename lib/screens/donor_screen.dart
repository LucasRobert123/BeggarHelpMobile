import 'package:beggarhelp/components/CustomTabBar/index.dart';
import 'package:flutter/material.dart';

class DonorScreen extends StatefulWidget {
  const DonorScreen({Key key}) : super(key: key);

  @override
  _DonorScreenState createState() => _DonorScreenState();
}

class _DonorScreenState extends State<DonorScreen> {
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
