import 'package:beggarhelp/components/CustomTabBar/index.dart';
import 'package:beggarhelp/models/Company.dart';
import 'package:beggarhelp/models/UserData.dart';
import 'package:beggarhelp/services/auth_service.dart';
import 'package:beggarhelp/services/firestore_service.dart';
import 'package:flutter/material.dart';

class CompanyScreen extends StatefulWidget {
  final UserData user;
  const CompanyScreen({Key key, this.user}) : super(key: key);

  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  Company user;
  @override
  void initState() {
    FirestoreService()
        .getUserData(AuthService.getCurrentUser().uid, "companies")
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
