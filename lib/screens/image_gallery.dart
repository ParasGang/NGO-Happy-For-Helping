import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/screens/zoom.dart';
import 'package:ngo_happy_to_help/widgets/navigation_drawer.dart';
import 'package:ngo_happy_to_help/widgets/top_bar.dart';

class ImageGallery extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
                Text(
                  'Image Gallery',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 10,
                      color: Color(0xff2C317A)),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.safeBlockHorizontal * 4),
                      height: SizeConfig.safeBlockVertical * 28,
                      child: ImageGalleryEventList()),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ImageGalleryEventList extends StatelessWidget {
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
                var imagesList = document['images'];
                return new Container(
                  margin:
                      EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
                  height: SizeConfig.safeBlockVertical * 26,
                  width: SizeConfig.safeBlockHorizontal * 94,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.safeBlockHorizontal * 6),
                          child: Text(
                            document['name'],
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            color: Colors.transparent,
                            height: SizeConfig.safeBlockVertical * 24,
                            width: SizeConfig.safeBlockHorizontal * 92,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: imagesList.length,
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ZoomableWidget(
                                            image: imagesList[i],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(
                                        SizeConfig.safeBlockHorizontal * 1),
                                    width: SizeConfig.safeBlockHorizontal * 35,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          imagesList[i],
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
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
