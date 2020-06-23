import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/widgets/navigation_drawer.dart';
import 'package:ngo_happy_to_help/widgets/top_bar.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String text1 =
      "Happy For Helping is a non-political and a non-profit organization committed to help people who are in need. Happy For Helping began in august in 2019 formed by a group of 18 young men in village of Kosmadi in Surat district.";

  String text2 =
      "We all 18 members of the organization pledge to never overlook any small opportunity of making our contribution towards making the society a better society for everyone to live wether it be a animal,plant,male or a female.";
  String text3 =
      "Happy For Helping needs help of private donations from caring people like you. Your donation will be used wisely, and you can enjoy the satisfaction of knowing that you are helping to relieve the burden of the society. Email us to request our Audited Financials statement. Happy For Helping is a non-profit organization and all donations will be used wisely and a record will be kept accordingly.";
  String text4 =
      "Our top priority is to help the person or a family in need without providing them any financial support and providing them any sort of requirement which is necessary for a good life.We assure all our donations and funds are taken care of properly and are not spent for any baseless use.";
  String text5 =
      "One main thing is the avaiblity of blood for every individual. We as a organization are available 24*7 if anybody needs blood in our area where we can reach them or arrange blood in your area through our contacts";
  String text6 =
      "For any suggestion you can feel free to write it in our suggestion column and for more details you can contact us directly.";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: NavigationDrawer(),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            TopBar(onTap: () {
              _scaffoldKey.currentState.openDrawer();
            }),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 3.7,
            ),
            Text(
              'About Us',
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 11,
                  color: Color(0xff2C317A)),
            ),
            Expanded(
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/a.png'),
                                fit: BoxFit.fill)),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.all(SizeConfig.safeBlockHorizontal * 4),
                      margin: EdgeInsets.only(
                          left: SizeConfig.safeBlockVertical * 5,
                          right: SizeConfig.safeBlockVertical * 5,
                          top: SizeConfig.safeBlockVertical * 2,
                          bottom: SizeConfig.safeBlockVertical * 8),
                      decoration: BoxDecoration(
                        color: Color(0xffF1F1F1).withOpacity(0.55),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.white),
                      ),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: <Widget>[
                            Text(
                              text1,
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 5),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 4,
                            ),
                            Text(
                              text2,
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 5),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 4,
                            ),
                            Text(
                              text3,
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 5),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 4,
                            ),
                            Text(
                              text4,
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 5),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 4,
                            ),
                            Text(
                              text5,
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 5),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 4,
                            ),
                            Text(
                              text6,
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
