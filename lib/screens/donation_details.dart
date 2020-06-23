import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngo_happy_to_help/screens/admin_add_donar.dart';
import 'package:ngo_happy_to_help/widgets/navigation_drawer.dart';
import 'package:ngo_happy_to_help/widgets/top_bar.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Donation extends StatefulWidget {
  @override
  _DonationState createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int role = 2;
  getRole() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    role = _prefs.getInt('role');
    setState(() {});
  }

  @override
  void initState() {
    getRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return role == 1
        ? AddDonar()
        : SafeArea(
            child: Scaffold(
              drawer: NavigationDrawer(),
              key: _scaffoldKey,
              backgroundColor: Colors.white,
              body: Column(
                children: <Widget>[
                  TopBar(
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical * 3),
                  Text(
                    'Make Donation',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 10.5,
                      color: Color(0xff2C317A),
                    ),
                  ),
                  Text(
                    'Donate for a great Cause',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 5.5,
                      color: Color(0xff2C317A).withOpacity(0.7),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1.8,
                  ),
                  Expanded(
                    child: Container(
                      width: SizeConfig.safeBlockHorizontal * 80,
                      height: SizeConfig.safeBlockVertical * 50,
                      padding: EdgeInsets.all(35),
                      decoration: BoxDecoration(
                          color: Color(0xfff2f2f2).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Bank Details",
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 5.5,
                                  color: Color(0xff707070)),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 3.7,
                            ),
                            Text(
                              "Account Number :",
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 6,
                                  color: Color(0xff707070)),
                            ),
                            Text(
                              "3596695387",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 6,
                                  color: Color(0xff707070)),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 3.7,
                            ),
                            Text(
                              "IFSC Code :",
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 6,
                                  color: Color(0xff707070)),
                            ),
                            Text(
                              "CBIN0280516",
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 6,
                                  color: Color(0xff707070)),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 3.7,
                            ),
                            Container(
                              width: SizeConfig.safeBlockHorizontal * 40,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffE949CF),
                                    Color(0xffD65318)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                        text:
                                            "Account Number: 37789011110 , IFSC Code: BARBN90"),
                                  );
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text('Copied to clipboard'),
                                    duration: Duration(seconds: 1),
                                  ));
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          SizeConfig.safeBlockVertical * 1.2),
                                  child: FittedBox(
                                    child: Text(
                                      "Copy Details",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 1,
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 1,
                            ),
                            Text(
                              "+91 95124 88599",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.safeBlockHorizontal * 5),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        'assets/images/paytm.svg',
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                        height: 100,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/phonepe.png',
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                        height: 100,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/gpay.png',
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    height: 100,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: SizeConfig.safeBlockHorizontal * 25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/a.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
