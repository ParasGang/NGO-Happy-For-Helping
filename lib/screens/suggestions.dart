import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/screens/suggestions_upload.dart';
import 'package:ngo_happy_to_help/service/database.dart';
import 'package:ngo_happy_to_help/widgets/navigation_drawer.dart';
import 'package:ngo_happy_to_help/widgets/top_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Suggestions extends StatefulWidget {
  @override
  _SuggestionsState createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
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
    return role == 2 ? SuggestionsUpload() : SuggestionFetch();
  }
}

class SuggestionFetch extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
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
                  'Suggestions',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 10,
                      color: Color(0xff2C317A)),
                ),
              ),
              Expanded(
                child: Container(
                    height: SizeConfig.safeBlockVertical * 50,
                    child: SuggestionList()),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

class SuggestionList extends StatefulWidget {
  @override
  _SuggestionListState createState() => _SuggestionListState();
}

class _SuggestionListState extends State<SuggestionList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('suggestion')
          .orderBy('created', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return new ListView(
              physics: BouncingScrollPhysics(),
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: new Container(
                    width: SizeConfig.safeBlockHorizontal * 90,
                    margin: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                    padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color(0xff707070).withOpacity(0.1)),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            document['suggestion'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 4.5),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 1.5,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "~ " + document['name'],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            document['email'],
                          ),
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
                        await db.deleteSuggestion(document.documentID);
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
