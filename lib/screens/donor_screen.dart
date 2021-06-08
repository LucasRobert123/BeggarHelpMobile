import 'package:beggarhelp/components/CustomTabBar/index.dart';
import 'package:beggarhelp/models/Donor.dart';
import 'package:beggarhelp/services/auth_service.dart';
import 'package:beggarhelp/services/firestore_service.dart';
import 'package:flutter/material.dart';

class DonorScreen extends StatefulWidget {
  const DonorScreen({Key key}) : super(key: key);

  @override
  _DonorScreenState createState() => _DonorScreenState();
}

class _DonorScreenState extends State<DonorScreen> {
  Donor user;
  @override
  void initState() {
    FirestoreService()
        .getUserData(AuthService.getCurrentUser().uid, "donors")
        .then((donor) => setState(() {
              user = donor;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomTabBar(
              name: user == null ? "Usuário" : user.name,
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
