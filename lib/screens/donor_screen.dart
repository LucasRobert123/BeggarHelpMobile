import 'package:beggarhelp/components/CardUser/index.dart';
import 'package:beggarhelp/components/CustomTabBar/index.dart';
import 'package:beggarhelp/models/Company.dart';
import 'package:beggarhelp/models/Donor.dart';
import 'package:beggarhelp/services/auth_service.dart';
import 'package:beggarhelp/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CustomTabBar(
                name: user == null ? "Usuário" : user.name.split(" ")[0],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Company>>(
                future: FirestoreService().getCompanies(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  if (snapshot.hasData) {
                    List<Company> companies = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: companies.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: CardUser(
                          name: companies[index].name,
                          text: companies[index].street,
                          onPress: () async {
                            await FirestoreService()
                                .makeContact(user.id, companies[index].id);
                            await launch(
                                "https://wa.me/${companies[index].phone}?text=Quero fazer uma doação!");
                          },
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
