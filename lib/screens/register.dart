import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/screens/home_page.dart';
import 'package:ngo_happy_to_help/service/user_handling.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _getToken() {
    _firebaseMessaging.getToken().then((tokens) {
      print("Device Token: $token");
      token = tokens;
    });
  }

  String token = "";
  String error = "";
  bool _isloading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var phone = TextEditingController();
  var cpassword = TextEditingController();

  @override
  void initState() {
    _getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _isloading == false
            ? Stack(
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
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 5,
                          width: double.infinity,
                        ),
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 7,
                            color: Color(0xff2D2B2B),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 1,
                          width: double.infinity,
                        ),
                        Text(
                          "Register Yourself in Happy For Helping",
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                            color: Color(0xff2D2B2B),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 2,
                          width: double.infinity,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xfff2f2f2).withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          //height: SizeConfig.safeBlockVertical * 65,
                          width: SizeConfig.safeBlockHorizontal * 90,
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.safeBlockHorizontal * 5),
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.safeBlockHorizontal * 5),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 4,
                                  width: double.infinity,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    return value.length < 3
                                        ? "Enter a Valid Name"
                                        : null;
                                  },
                                  controller: name,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3.8),
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    prefixIcon: Icon(
                                      Icons.person,
                                      size:
                                          SizeConfig.safeBlockHorizontal * 5.5,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 3,
                                  width: double.infinity,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(value))
                                      return 'Enter Valid Email';
                                    else
                                      return null;
                                  },
                                  controller: email,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3.8),
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    prefixIcon: Icon(
                                      Icons.mail,
                                      size:
                                          SizeConfig.safeBlockHorizontal * 5.5,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 3,
                                  width: double.infinity,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    return value.length < 10
                                        ? "Enter a Valid Phone Number"
                                        : null;
                                  },
                                  controller: phone,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3.8),
                                  decoration: InputDecoration(
                                    hintText: "Phone Number",
                                    prefixIcon: Icon(
                                      Icons.call,
                                      size:
                                          SizeConfig.safeBlockHorizontal * 5.5,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 3,
                                  width: double.infinity,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    return value.length < 6
                                        ? "Password length must be greater than 6"
                                        : null;
                                  },
                                  obscureText: true,
                                  controller: password,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3.8),
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      size:
                                          SizeConfig.safeBlockHorizontal * 5.5,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 3,
                                  width: double.infinity,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    return value != password.text
                                        ? "Both password are not same"
                                        : null;
                                  },
                                  obscureText: true,
                                  controller: cpassword,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3.8),
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      size:
                                          SizeConfig.safeBlockHorizontal * 5.5,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 3,
                                  width: double.infinity,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 4,
                          width: double.infinity,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),
                        Container(
                          width: SizeConfig.safeBlockHorizontal * 55,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xffE949CF), Color(0xffD65318)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: FlatButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  _isloading = true;
                                });
                                UserHandling _handle = UserHandling();
                                var uid =
                                    await _handle.registerWithEmailAndPassword(
                                        email.text, password.text);

                                if (uid == null) {
                                  setState(() {
                                    error = "You are already registered";
                                    _isloading = false;
                                  });
                                } else {
                                  await _handle.uploadUserData(phone.text, uid,
                                      name.text, email.text, token, 2);
                                  await _handle.currentUserData();

                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return HomePage();
                                  }));
                                  setState(() {
                                    _isloading = false;
                                  });
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 5.5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 5,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
