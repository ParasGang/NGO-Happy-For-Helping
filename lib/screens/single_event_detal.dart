import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/screens/zoom.dart';
import 'package:ngo_happy_to_help/widgets/navigation_drawer.dart';
import 'package:ngo_happy_to_help/widgets/top_bar.dart';

class SingleEventDetail extends StatelessWidget {
  final String name, date, cover, description;
  final List images;
  SingleEventDetail(
      {this.name, this.date, this.cover, this.images, this.description});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
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
                    print(name + date + cover);
                  },
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                Text(
                  name,
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 10,
                      color: Color(0xff2C317A)),
                ),
                Text(
                  date,
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 6,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.normal),
                ),
                Container(
                  width: SizeConfig.safeBlockHorizontal * 94,
                  height: SizeConfig.safeBlockVertical * 20,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal * 5),
                  child: SingleChildScrollView(
                    child: Text(
                      description,
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                    height: SizeConfig.safeBlockVertical * 30,
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ZoomableWidget(
                                      image: images[index],
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              width: SizeConfig.safeBlockHorizontal * 39,
                              height: SizeConfig.safeBlockHorizontal * 20,
                              margin: EdgeInsets.all(
                                  SizeConfig.safeBlockHorizontal * 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      images[index],
                                    ),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
