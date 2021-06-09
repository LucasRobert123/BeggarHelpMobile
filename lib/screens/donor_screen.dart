import 'package:beggarhelp/components/CardUser/index.dart';
import 'package:beggarhelp/components/CustomTabBar/index.dart';
import 'package:beggarhelp/components/Modal/index.dart';
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
                                  itemModal(companies[index].name,
                                      Icons.account_balance),
                                  itemModal(
                                      companies[index].phone, Icons.phone),
                                  itemModal(
                                      companies[index].email, Icons.email),
                                  itemModal(
                                      "${companies[index].street}, ${companies[index].num},${companies[index].district},${companies[index].city}-${companies[index].uf}",
                                      Icons.place),
                                ],
                              ),
                            );
                          },
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
