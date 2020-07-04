import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/service/database.dart';
import 'package:ngo_happy_to_help/widgets/navigation_drawer.dart';
import 'package:ngo_happy_to_help/widgets/top_bar.dart';

class DeleteThought extends StatelessWidget {
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
                      fit: BoxFit.fill),
                ),
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
                  'Thoughts',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 11,
                      color: Color(0xff2C317A)),
                ),
                Expanded(
                  child: Container(
                    width: SizeConfig.safeBlockHorizontal * 90,
                    height: SizeConfig.safeBlockVertical * 40,
                    padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
                    child: ThoughtList(),
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

class ThoughtList extends StatefulWidget {
  @override
  _ThoughtListState createState() => _ThoughtListState();
}

class _ThoughtListState extends State<ThoughtList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('thought')
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
              children: snapshot.data.documents.map(
                (DocumentSnapshot document) {
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
                      padding:
                          EdgeInsets.all(SizeConfig.safeBlockHorizontal * 1),
                      margin:
                          EdgeInsets.all(SizeConfig.safeBlockHorizontal * 1),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff707070).withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: <Widget>[
                          document['text'] != null
                              ? Text(
                                  document['text'],
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 5),
                                )
                              : null,
                          document['image'] != null
                              ? Padding(
                                  padding: EdgeInsets.all(
                                      SizeConfig.safeBlockHorizontal * 2),
                                  child: Image(
                                    image: NetworkImage(
                                      document['image'],
                                    ),
                                  ),
                                )
                              : null,
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 18.0),
                              child: Text(
                                "${(DateTime.parse(document['created'].toDate().toString())).day}-${(DateTime.parse(document['created'].toDate().toString())).month}-${(DateTime.parse(document['created'].toDate().toString())).year}",
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4),
                              ),
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
                          await db.deleteThought(document.documentID);
                          setState(() {});
                        },
                      ),
                    ],
                  );
                },
              ).toList(),
            );
        }
      },
    );
  }
}
