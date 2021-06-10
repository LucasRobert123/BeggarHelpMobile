import 'package:beggarhelp/components/CardUser/index.dart';
import 'package:beggarhelp/components/CustomTabBar/index.dart';
import 'package:beggarhelp/components/Modal/index.dart';
import 'package:beggarhelp/models/Company.dart';
import 'package:beggarhelp/models/Donor.dart';
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
    itemModal(String item, IconData name) {
      return Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              name,
              size: 30,
              color: Color(0xFFEBCE34),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 35,
                child: Text(
                  item,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF31CF2B),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

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
                    if (snapshot.data.isEmpty) {
                      return Center(
                        child: Text(
                          'Não existem doadores interessados a doar na sua instituição',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF31CF2B),
                              fontSize: 20),
                        ),
                      );
                    } else {
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
                            onDetails: () {
                              Modal.showAlertDialog(
                                context,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Detalhes',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24,
                                          color: Color(0xFF31CF2B),
                                        ),
                                      ),
                                    ),
                                    itemModal(donors[index].name, Icons.person),
                                    itemModal(donors[index].phone, Icons.phone),
                                    itemModal(donors[index].email, Icons.email),
                                    itemModal(
                                        "${donors[index].street}, ${donors[index].num},${donors[index].district},${donors[index].city}-${donors[index].uf}",
                                        Icons.place),
                                  ],
                                ),
                              );
                            },
                            onRemove: () {
                              FirestoreService().removeContact(
                                  AuthService.getCurrentUser().uid,
                                  donors[index].id);

                              setState(() {});
                            },
                          ),
                        ),
                      );
                    }
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
