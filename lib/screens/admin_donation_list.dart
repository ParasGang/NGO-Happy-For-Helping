import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/service/database.dart';
import 'package:ngo_happy_to_help/widgets/navigation_drawer.dart';
import 'package:ngo_happy_to_help/widgets/top_bar.dart';

class AdminDonationList extends StatelessWidget {
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
                  'Donar List',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 10,
                      color: Color(0xff2C317A)),
                ),
              ),
              Expanded(
                child: Container(
                    height: SizeConfig.safeBlockVertical * 50,
                    child: HappyForHelpingDonarList()),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

class HappyForHelpingDonarList extends StatefulWidget {
  @override
  _HappyForHelpingDonarListState createState() =>
      _HappyForHelpingDonarListState();
}

class _HappyForHelpingDonarListState extends State<HappyForHelpingDonarList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('donation')
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
                    padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: document['pay'] == true
                            ? Colors.greenAccent
                            : Colors.redAccent),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Name :- ${document['name']}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 5.5),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 1.5,
                        ),
                        Container(
                          child: Text(
                            "Amount :-  ${document['amount']}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 5.5),
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
                        await db.deleteDonar(document.documentID);
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
