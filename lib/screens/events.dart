import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/models/event.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/screens/single_event_detal.dart';
import 'package:ngo_happy_to_help/screens/testing.dart';
import 'package:ngo_happy_to_help/screens/zoom.dart';
import 'package:ngo_happy_to_help/service/database.dart';
import 'package:ngo_happy_to_help/service/user_handling.dart';
import 'package:ngo_happy_to_help/widgets/navigation_drawer.dart';
import 'package:ngo_happy_to_help/widgets/top_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  int role;
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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
            TopBar(
              onTap: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 3.7,
            ),
            Text(
              'Events',
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 10,
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
                    role == 2 ? EventList() : AdminEventList(),
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

class EventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('ngo').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return new ListView(
              physics: BouncingScrollPhysics(),
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new Container(
                  margin: EdgeInsets.symmetric(
                      vertical: SizeConfig.safeBlockHorizontal * 2,
                      horizontal: SizeConfig.safeBlockHorizontal * 4),
                  padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                  width: SizeConfig.safeBlockHorizontal * 90,
                  decoration: BoxDecoration(
                    color: Color(0xfff7f7f7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ZoomableWidget(
                                    image: document['cover'],
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            child: Image.network(document['cover'] ??
                                "assets/images/charity.png"),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: SizeConfig.safeBlockHorizontal * 4),
                            width: SizeConfig.safeBlockHorizontal * 50,
                            child: Text(
                              document['name'],
                              style: TextStyle(
                                  color: Color(0xff2C317A),
                                  fontSize: SizeConfig.safeBlockHorizontal * 5),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: SizeConfig.safeBlockHorizontal * 4),
                            width: SizeConfig.safeBlockHorizontal * 50,
                            child: Text(
                              document['date'],
                              style: TextStyle(
                                  color: Color(0xff707070).withOpacity(0.7),
                                  fontSize: SizeConfig.safeBlockHorizontal * 5),
                            ),
                          ),
                          Container(
                            width: SizeConfig.safeBlockHorizontal * 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff707070)),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return SingleEventDetail(
                                    name: document['name'] ?? "",
                                    date: document['date'] ?? "",
                                    cover: document['cover'] ?? "",
                                    images: document['images'] ?? [],
                                    description: document['description'] ?? "",
                                  );
                                }));
                              },
                              child: Text(
                                "View Details",
                                style: TextStyle(
                                    color: Color(0xff707070),
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4.5,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
}

class AdminEventList extends StatefulWidget {
  @override
  _AdminEventListState createState() => _AdminEventListState();
}

class _AdminEventListState extends State<AdminEventList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('ngo').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return new ListView(
              physics: BouncingScrollPhysics(),
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Slidable(
                  actionExtentRatio: 0.25,
                  actionPane: SlidableDrawerActionPane(),
                  child: new Container(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.safeBlockHorizontal * 2,
                        horizontal: SizeConfig.safeBlockHorizontal * 4),
                    padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                    width: SizeConfig.safeBlockHorizontal * 90,
                    decoration: BoxDecoration(
                      color: Color(0xfff7f7f7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ZoomableWidget(
                                      image: document['cover'],
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              child: Image.network(document['cover'] ??
                                  "assets/images/charity.png"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal * 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.safeBlockHorizontal * 4),
                              width: SizeConfig.safeBlockHorizontal * 50,
                              child: Text(
                                document['name'],
                                style: TextStyle(
                                    color: Color(0xff2C317A),
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 5),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.safeBlockHorizontal * 4),
                              width: SizeConfig.safeBlockHorizontal * 50,
                              child: Text(
                                document['date'] ?? "",
                                style: TextStyle(
                                    color: Color(0xff707070).withOpacity(0.7),
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 5),
                              ),
                            ),
                            Container(
                              width: SizeConfig.safeBlockHorizontal * 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff707070)),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  print(document.documentID);
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return UpdateEvents(
                                      editname: document['name'] ?? "",
                                      editdate: document['date'] ?? "",
                                      //editcover: document['cover'] ?? "",
                                      editimagesList: document['images'] ?? [],
                                      editdescription:
                                          document['description'] ?? "",
                                      documnetId: document.documentID,
                                    );
                                  }));
                                },
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                      color: Color(0xff707070),
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4.5,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () async {
                        Database db = Database();
                        await db.deleteEvent(document.documentID);
                        setState(() {});
                      },
                    ),
                  ],
                );
              }).toList(),
            );
        }
      },
    );
  }
}
