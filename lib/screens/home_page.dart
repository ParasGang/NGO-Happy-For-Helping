import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/screens/about.dart';
import 'package:ngo_happy_to_help/screens/admin_donation_list.dart';
import 'package:ngo_happy_to_help/screens/contact_us.dart';
import 'package:ngo_happy_to_help/screens/daily_thoughts.dart';
import 'package:ngo_happy_to_help/screens/events.dart';
import 'package:ngo_happy_to_help/screens/image_gallery.dart';
import 'package:ngo_happy_to_help/screens/social_accounts.dart';
import 'package:ngo_happy_to_help/screens/suggestions.dart';
import 'package:ngo_happy_to_help/screens/testing.dart';
import 'package:ngo_happy_to_help/widgets/navigation_drawer.dart';
import 'package:ngo_happy_to_help/widgets/top_bar.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String testDevice = "MobileId";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int role = 2;
  getRole() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    role = _prefs.getInt('role');
    setState(() {});
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _getToken() {
    _firebaseMessaging.getToken().then((token) {
      print("Device Token: $token");
    });
  }

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: ListTile(
              title: Text(
                message['notification']['title'],
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                message['notification']['body'],
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Events()));
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  static final MobileAdTargetingInfo targetInfo = MobileAdTargetingInfo(
      testDevices: <String>[],
      childDirected: true,
      keywords: <String>[
        "social",
        "ngo",
      ]);

  int _coins = 0;
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  var isViewed = 0;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: "ca-app-pub-4037369978677782/5085474094",
        size: AdSize.banner,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {
          print("Banner event:- $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: "ca-app-pub-4037369978677782/5812517815",
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {
          print("Interstitial event:- $event");
        });
  }

  @override
  void initState() {
    super.initState();
    getRole();
    _getToken();
    _configureFirebaseListeners();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-4037369978677782~7711637430");
    _bannerAd = createBannerAd()
      ..load()
      ..show();

    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("REWARDED VIDEO AD $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        _coins += rewardAmount;
      }
    };
    videoAd.load(
        adUnitId: "ca-app-pub-4037369978677782/2144929065",
        targetingInfo: targetInfo);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd.dispose();
    //_interstitialAd.dispose();
    super.dispose();
  }

  Future<bool> _onBackPress() async {
    await videoAd.show();
    return true;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: SafeArea(
          child: Scaffold(
        key: _scaffoldKey,
        drawer: NavigationDrawer(),
        backgroundColor: Colors.white,
        body: Stack(
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
            Column(
              children: <Widget>[
                TopBar(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    height: 100,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    HomePageContainer(
                      name: "Events",
                      image: 'assets/images/event.png',
                      onTap: () {
                        createInterstitialAd()
                          ..load()
                          ..show();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return Events();
                            },
                          ),
                        );
                      },
                    ),
                    HomePageContainer(
                        image: 'assets/images/image.png',
                        name: "Image Gallery",
                        onTap: () {
                          createInterstitialAd()
                            ..load()
                            ..show();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ImageGallery();
                              },
                            ),
                          );
                        }),
                  ],
                ),
                Flexible(
                  flex: 3,
                  child: SizedBox(
                    height: 100,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    HomePageContainer(
                      image: 'assets/images/suggestion.png',
                      name: "Suggestions",
                      onTap: () {
                        createInterstitialAd()
                          ..load()
                          ..show();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return Suggestions();
                            },
                          ),
                        );
                      },
                    ),
                    role == 2
                        ? HomePageContainer(
                            name: "Thoughts",
                            image: 'assets/images/thought.png',
                            onTap: () {
                              createInterstitialAd()
                                ..load()
                                ..show();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DailyThoughts();
                                  },
                                ),
                              );
                            },
                          )
                        : HomePageContainer(
                            name: "Donar List",
                            image: 'assets/images/donation.png',
                            onTap: () {
                              createInterstitialAd()
                                ..load()
                                ..show();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AdminDonationList();
                                  },
                                ),
                              );
                            },
                          ),
                  ],
                ),
                Flexible(
                  flex: 3,
                  child: SizedBox(
                    height: 100,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    HomePageContainer(
                      name: "Contact Us",
                      image: 'assets/images/contact.png',
                      onTap: () {
                        createInterstitialAd()
                          ..load()
                          ..show();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ContactUs();
                            },
                          ),
                        );
                      },
                    ),
                    HomePageContainer(
                      image: 'assets/images/social.png',
                      name: "Social Accounts",
                      onTap: () {
                        createInterstitialAd()
                          ..load()
                          ..show();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return SocialAccounts();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Flexible(
                  flex: 7,
                  child: SizedBox(
                    height: 100,
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

class HomePageContainer extends StatelessWidget {
  final Function onTap;
  final name, image;
  HomePageContainer({this.image, this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: SizeConfig.safeBlockHorizontal * 41,
          height: SizeConfig.safeBlockVertical * 21,
          padding: EdgeInsets.only(
            top: SizeConfig.safeBlockHorizontal * 4,
            left: SizeConfig.safeBlockHorizontal * 4,
            right: SizeConfig.safeBlockHorizontal * 4,
            bottom: SizeConfig.safeBlockHorizontal * 1.5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6.0,
                  offset: Offset(4, 4)),
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2.0,
                  offset: Offset(-2, -2))
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
              FittedBox(
                child: Text(
                  name,
                  style: TextStyle(
                      color: Color(0xff2C317A),
                      fontSize: SizeConfig.safeBlockHorizontal * 4.5),
                ),
              ),
            ],
          )),
    );
  }
}
