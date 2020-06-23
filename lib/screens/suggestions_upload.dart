import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/service/database.dart';
import 'package:ngo_happy_to_help/widgets/navigation_drawer.dart';
import 'package:ngo_happy_to_help/widgets/top_bar.dart';

class SuggestionsUpload extends StatefulWidget {
  @override
  _SuggestionsUploadState createState() => _SuggestionsUploadState();
}

class _SuggestionsUploadState extends State<SuggestionsUpload> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var _name = TextEditingController();
  var _email = TextEditingController();
  var _suggestion = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      drawer: NavigationDrawer(),
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
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
            'Suggestion',
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
                    padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 4),
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
                      child: Form(
                        key: _key,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (value) {
                                return value == "" ? "Enter Name" : null;
                              },
                              controller: _name,
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 4),
                              decoration: InputDecoration(
                                  hintText: 'Name',
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 3,
                            ),
                            TextFormField(
                              validator: (value) {
                                return value == "" ? "Enter Email" : null;
                              },
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 4),
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  prefixIcon: Icon(Icons.mail)),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 3,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.lightbulb_outline,
                                  size: SizeConfig.safeBlockHorizontal * 5.8,
                                  color: Color(0xff707070),
                                ),
                                SizedBox(
                                    width: SizeConfig.safeBlockHorizontal * 2),
                                Text(
                                  "Suggestion",
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4,
                                    color: Color(0xff707070),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 1,
                            ),
                            TextFormField(
                              validator: (value) {
                                return value == "" ? "Enter Suggestion" : null;
                              },
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 4),
                              controller: _suggestion,
                              maxLines: 3,
                              decoration: InputDecoration(
                                // filled: true,
                                // fillColor: Color(0xff707070).withOpacity(0.1),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            SizedBox(height: SizeConfig.safeBlockVertical * 3),
                            Container(
                              width: SizeConfig.safeBlockHorizontal * 35,
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
                                onPressed: () async {
                                  if (_key.currentState.validate()) {
                                    Database db = Database();
                                    await db.suggestionUpload(_name.text,
                                        _email.text, _suggestion.text);
                                    _name.clear();
                                    _email.clear();
                                    _suggestion.clear();
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text('Suggestion Send Successfully'),
                                      duration: Duration(seconds: 2),
                                    ));
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 5),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
