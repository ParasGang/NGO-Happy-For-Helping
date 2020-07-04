import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/screens/about.dart';
import 'package:ngo_happy_to_help/screens/add_events.dart';
import 'package:ngo_happy_to_help/screens/contact_us.dart';
import 'package:ngo_happy_to_help/screens/delete_thought.dart';
import 'package:ngo_happy_to_help/screens/donation_details.dart';
import 'package:ngo_happy_to_help/screens/entry_page.dart';
import 'package:ngo_happy_to_help/screens/events.dart';
import 'package:ngo_happy_to_help/screens/home_page.dart';
import 'package:ngo_happy_to_help/screens/image_gallery.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/screens/login.dart';
import 'package:ngo_happy_to_help/screens/suggestions.dart';
import 'package:ngo_happy_to_help/screens/thoughts_upload.dart';
import 'package:ngo_happy_to_help/screens/user_profile_update.dart';
import 'package:ngo_happy_to_help/service/authentication.dart';
import 'package:ngo_happy_to_help/service/user_handling.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String name = '', email = '', photo = '', phone = "", uid = "";
  int role = 0;

  getData() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      name = _prefs.getString('name') ?? "";
      email = _prefs.getString('email') ?? "";
      photo = _prefs.getString('photo') ?? "";
      phone = _prefs.getString('phone') ?? "";
      uid = _prefs.getString('uid') ?? "";
      print(photo);
      role = _prefs.getInt('role');
      print(role);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              height: SizeConfig.safeBlockVertical * 50,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return UserProfileUpdate(
                          nameA: name,
                          phoneA: phone,
                          photoA: photo,
                          uidA: uid,
                        );
                      }));
                    },
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color(0xff7F8C8D),
                        Color(0xffD3D3D3),
                      ])),
                      accountName: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          name,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      accountEmail: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          email,
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: photo == ""
                            ? AssetImage("assets/images/avatar.png")
                            : NetworkImage(photo),
                      ),
                    ),
                  ),
                  Center(
                      child: Text(
                    "Happy For Helping",
                    style: TextStyle(
                        color: Color(0xff2C317A),
                        fontSize: SizeConfig.safeBlockHorizontal * 5),
                  )),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }));
                    },
                    leading: Icon(
                      Icons.home,
                      color: Color(0xff707070),
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(
                          color: Color(0xff707070),
                          fontSize: SizeConfig.safeBlockHorizontal * 4),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Donation();
                      }));
                    },
                    leading: Icon(
                      Icons.account_balance,
                      color: Color(0xff707070),
                    ),
                    title: Text(
                      "Donation",
                      style: TextStyle(
                          color: Color(0xff707070),
                          fontSize: SizeConfig.safeBlockHorizontal * 4),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Suggestions();
                      }));
                    },
                    leading: Icon(
                      Icons.lightbulb_outline,
                      color: Color(0xff707070),
                    ),
                    title: Text(
                      "Suggestions",
                      style: TextStyle(
                          color: Color(0xff707070),
                          fontSize: SizeConfig.safeBlockHorizontal * 4),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ContactUs();
                      }));
                    },
                    leading: Icon(
                      Icons.contact_mail,
                      color: Color(0xff707070),
                    ),
                    title: Text(
                      "Contact us",
                      style: TextStyle(
                          color: Color(0xff707070),
                          fontSize: SizeConfig.safeBlockHorizontal * 4),
                    ),
                  ),
                  role == 1
                      ? ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return AddEvents();
                            }));
                          },
                          leading: Icon(
                            Icons.lightbulb_outline,
                            color: Color(0xff707070),
                          ),
                          title: Text(
                            "Add Events",
                            style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: SizeConfig.safeBlockHorizontal * 4),
                          ),
                        )
                      : ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return About();
                            }));
                          },
                          leading: Icon(
                            Icons.info_outline,
                            color: Color(0xff707070),
                          ),
                          title: Text(
                            "About Us",
                            style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: SizeConfig.safeBlockHorizontal * 4),
                          ),
                        ),
                  role == 1
                      ? ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return ThoughtsUpload();
                            }));
                          },
                          leading: Icon(
                            Icons.lightbulb_outline,
                            color: Color(0xff707070),
                          ),
                          title: Text(
                            "Add Thought",
                            style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: SizeConfig.safeBlockHorizontal * 4),
                          ),
                        )
                      : ListTile(),
                      role == 1
                      ? ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return DeleteThought();
                            }));
                          },
                          leading: Icon(
                            Icons.delete,
                            color: Color(0xff707070),
                          ),
                          title: Text(
                            "Delete Thought",
                            style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: SizeConfig.safeBlockHorizontal * 4),
                          ),
                        )
                      : ListTile()
                ],
              ),
            ),
          ),
          ListTile(
            onTap: () async {
              SharedPreferences _prefs = await SharedPreferences.getInstance();
              _prefs.remove("uid");
              await UserHandling().signOut();
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return Login();
              }));
            },
            leading: Icon(
              Icons.exit_to_app,
              color: Color(0xff707070),
            ),
            title: Text(
              "LogOut",
              style: TextStyle(
                  color: Color(0xff707070),
                  fontSize: SizeConfig.safeBlockHorizontal * 4),
            ),
          ),
          ListTile(
            onTap: () async {},
            title: Text(
              "",
              style: TextStyle(
                  color: Color(0xff707070),
                  fontSize: SizeConfig.safeBlockHorizontal * 4),
            ),
          ),
        ],
      ),
    );
  }
}
