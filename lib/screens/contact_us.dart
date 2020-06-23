import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/models/user.dart';
import 'package:ngo_happy_to_help/widgets/navigation_drawer.dart';
import 'package:ngo_happy_to_help/widgets/top_bar.dart';

class ContactUs extends StatelessWidget {
  List<Admin> adminUser = [
    Admin(
        bloodGroup: "AB+",
        name: "Adarsh Patel",
        image: "18.jpeg",
        mob: "+91 96243 77712"),
    Admin(
        bloodGroup: "O+",
        name: "Akshay Patel",
        image: "11.jpeg",
        mob: "+91 90231 06174"),
    Admin(
        bloodGroup: "O+",
        name: "Akshay Patel",
        image: "2.jpeg",
        mob: "+91 97734 48251"),
    Admin(
        bloodGroup: "B+",
        name: "Arpit Patel",
        image: "13.jpeg",
        mob: "+91 98797 26453"),
    Admin(
        bloodGroup: "O+",
        name: "Bhavik Patel",
        image: "7.jpeg",
        mob: "+91 63552 28609"),
    Admin(
        bloodGroup: "B+",
        name: "Bhavik Patel",
        image: "10.jpeg",
        mob: "+91 97262 18224"),
    Admin(
        bloodGroup: "A-",
        name: "Darshan Patel",
        image: "12.jpeg",
        mob: "+91 95372 18885"),
    Admin(
        bloodGroup: "O+",
        name: "Jeel Patel",
        image: "15.jpeg",
        mob: "+91 84698 32804"),
    Admin(
        bloodGroup: "O+",
        name: "Kishan Patel",
        image: "4.jpeg",
        mob: "+91 95124 88599"),
    Admin(
        bloodGroup: "B+",
        name: "Nitul Patel",
        image: "8.jpeg",
        mob: "+91 99259 81706"),
    Admin(
        bloodGroup: "O+",
        name: "Om Patel",
        image: "1.jpeg",
        mob: "+91 90996 47616"),
    Admin(
        bloodGroup: "O+",
        name: "Pinkal Patel",
        image: "9.jpeg",
        mob: "+91 81414 33634"),
    Admin(
        bloodGroup: "AB+",
        name: "Priyanshu Patel",
        image: "6.jpeg",
        mob: "+91 96877 90817"),
    Admin(
        bloodGroup: "B+",
        name: "Rohan Patel",
        image: "17.jpeg",
        mob: "+91 95864 85817"),
    Admin(
        bloodGroup: "B+",
        name: "Shivam Patel",
        image: "5.jpeg",
        mob: "+91 97266 82782"),
    Admin(
        bloodGroup: "O+",
        name: "Shivam S. Patel",
        image: "3.jpeg",
        mob: "+91 99787 85883"),
    Admin(
        bloodGroup: "O+",
        name: "Urvin Patel",
        image: "14.jpeg",
        mob: "+91 97378 02203"),
    Admin(
        bloodGroup: "AB+",
        name: "Vatsala Patel",
        image: "16.jpeg",
        mob: "+91 70698 31298"),
  ];
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        drawer: NavigationDrawer(),
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: SizeConfig.safeBlockVertical * 12,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/a.png'),
                        fit: BoxFit.fill)),
              ),
            ),
            Column(
              children: <Widget>[
                TopBar(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 3.7,
                ),
                Text(
                  'Contact Us',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 11,
                      color: Color(0xff2C317A)),
                ),
                Expanded(
                  child: Container(
                      margin:
                          EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                      height: SizeConfig.safeBlockVertical * 60,
                      width: SizeConfig.safeBlockHorizontal * 90,
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 4 / 7,
                        children: adminUser.map((e) {
                          return Container(
                            margin: EdgeInsets.all(
                                SizeConfig.safeBlockHorizontal * 2),
                            width: SizeConfig.safeBlockHorizontal * 40,
                            decoration: BoxDecoration(
                              color: Color(0xff2C317A),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: SizeConfig.safeBlockHorizontal * 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/admin/${e.image}',
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        FittedBox(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: SizeConfig
                                                        .safeBlockHorizontal *
                                                    2),
                                            child: Text(
                                              e.name,
                                              style: TextStyle(
                                                  color: Color(0xffffffff),
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      5.2),
                                            ),
                                          ),
                                        ),
                                        FittedBox(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: SizeConfig
                                                        .safeBlockHorizontal *
                                                    2),
                                            child: Text(
                                              e.mob,
                                              style: TextStyle(
                                                  color: Color(0xffffffff),
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      4.5),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Container(
                                              color: Colors.transparent,
                                              width: SizeConfig
                                                      .safeBlockHorizontal *
                                                  10,
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/images/blood.png"),
                                              ),
                                            ),
                                            Text(
                                              e.bloodGroup,
                                              style: TextStyle(
                                                  color: Color(0xffffffff),
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      5),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
