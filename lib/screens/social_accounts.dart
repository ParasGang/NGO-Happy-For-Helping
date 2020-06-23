import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/widgets/navigation_drawer.dart';
import 'package:ngo_happy_to_help/widgets/top_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialAccounts extends StatelessWidget {
  _launchURL(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

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
                FittedBox(
                  child: Text(
                    'Social Accounts',
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 10,
                        color: Color(0xff2C317A)),
                  ),
                ),
                Text(
                  'Follow Us On',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 7,
                      color: Color(0xff000000)),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 5,
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL('https://www.instagram.com/happy_for_helping/');
                  },
                  child: SvgPicture.asset(
                    'assets/images/instagram.svg',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    height: 100,
                  ),
                ),
                Text(
                  'Instagram',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 5,
                      color: Color(0xff000000)),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: SizeConfig.safeBlockVertical * 5,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL('akipatel6864.wixsite.com/happyforhelping');
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    child: Image.asset(
                      'assets/images/charity.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      height: 100,
                    ),
                  ),
                ),
                Text(
                  'Website',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 5,
                      color: Color(0xff000000)),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: SizeConfig.safeBlockVertical * 5,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
