import 'package:beggarhelp/components/CardUser/index.dart';
import 'package:beggarhelp/components/CustomTabBar/index.dart';
import 'package:beggarhelp/models/Company.dart';
import 'package:beggarhelp/models/Donor.dart';
import 'package:beggarhelp/models/UserData.dart';
import 'package:beggarhelp/services/auth_service.dart';
import 'package:beggarhelp/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({Key key}) : super(key: key);

  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  Company user;

  @override
  void initState() {
    FirestoreService()
        .getUserData(AuthService.getCurrentUser().uid, "companies")
        .then((company) => setState(() {
              user = company;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CustomTabBar(
                name: user == null ? "Instituição" : user.name.split(" ")[0],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Donor>>(
                future: FirestoreService()
                    .getDonorsByCompanyUID(AuthService.getCurrentUser().uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  if (snapshot.hasData) {
                    List<Donor> donors = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: donors.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: CardUser(
                          name: donors[index].name,
                          text: donors[index].street,
                          onPress: () async => await launch(
                              "https://wa.me/${donors[index].phone}?text=Olá, você tem interesse em nos fazer uma doação?"),
                          onDetails: () {},
                          onRemove: () {},
                        ),
                      ),
                    );
                  } else
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Color(0xFF31CF2B)),
                    ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
