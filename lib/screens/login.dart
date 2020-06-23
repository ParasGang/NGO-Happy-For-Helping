import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/screens/admin_register.dart';
import 'package:ngo_happy_to_help/screens/events.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/screens/forgot_password.dart';
import 'package:ngo_happy_to_help/screens/home_page.dart';
import 'package:ngo_happy_to_help/screens/register.dart';
import 'package:ngo_happy_to_help/service/authentication.dart';
import 'package:ngo_happy_to_help/service/user_handling.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _getToken() {
    _firebaseMessaging.getToken().then((tokens) {
      print("Device Token: $token");
      token = tokens;
    });
  }

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  String token = "";

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isloading = false;
  String email = '', password = '', error = '';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 4,
                          width: SizeConfig.safeBlockHorizontal * 100,
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 25,
                          child: Image.asset(
                            'assets/images/charity.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 3,
                          width: SizeConfig.safeBlockHorizontal * 100,
                        ),
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                              color: Color(0xff2D2B2B),
                              fontSize: SizeConfig.safeBlockHorizontal * 5.5),
                        ),
                        Text(
                          "Please Sign in to continue",
                          style: TextStyle(
                              color: Color(0xff707070).withOpacity(0.6),
                              fontSize: SizeConfig.safeBlockHorizontal * 4),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 2,
                        ),
                        Container(
                          padding: EdgeInsets.all(
                              SizeConfig.safeBlockHorizontal * 4),
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.safeBlockHorizontal * 8),
                          width: SizeConfig.safeBlockHorizontal * 84,
                          decoration: BoxDecoration(
                              color: Color(0xfff2f2f2).withOpacity(0.6),
                              borderRadius: BorderRadius.circular(25)),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Color(0xff2C317A),
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4.5),
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 2,
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
                                  onChanged: (value) => email = value,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3.8),
                                  decoration: InputDecoration(
                                    hintText: "Username",
                                    prefixIcon: Icon(
                                      Icons.mail,
                                      size:
                                          SizeConfig.safeBlockHorizontal * 5.5,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 1,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    return value.length < 6
                                        ? "Password length must be greater than 6"
                                        : null;
                                  },
                                  obscureText: true,
                                  onChanged: (value) => password = value,
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
                                  height: SizeConfig.safeBlockVertical * 2,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ForgotPassword();
                                    }));
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color: Color(0xff2C317A),
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal *
                                                3.5),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 2,
                                ),
                                Text(
                                  error,
                                  style: TextStyle(color: Colors.red),
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockVertical * 1,
                                ),
                                Container(
                                  width: SizeConfig.safeBlockHorizontal * 55,
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
                                      setState(() {
                                        _isloading = true;
                                      });
                                      if (_formkey.currentState.validate()) {
                                        UserHandling _handle = UserHandling();
                                        var uid = await _handle
                                            .loginWithEmailAndPassword(
                                                email, password);

                                        if (uid == null) {
                                          setState(() {
                                            error =
                                                "Either email or password is incorrect";
                                            _isloading = false;
                                          });
                                        } else {
                                          await Firestore.instance
                                              .collection("users")
                                              .document(uid)
                                              .updateData(
                                                  {"device_token": token});
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return HomePage();
                                          }));
                                          setState(() {
                                            _isloading = false;
                                          });
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Text(
                                        "Continue",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    5.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 2,
                        ),
                        Container(
                          padding: EdgeInsets.all(
                              SizeConfig.safeBlockHorizontal * 1),
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.safeBlockHorizontal * 8),
                          width: SizeConfig.safeBlockHorizontal * 84,
                          decoration: BoxDecoration(
                              color: Color(0xfff2f2f2).withOpacity(0.6),
                              borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 5),
                              ),
                              SizedBox(
                                height: SizeConfig.safeBlockVertical * 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: SizeConfig.safeBlockHorizontal * 30,
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: FlatButton(
                                      onPressed: () async {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return AdminRegister();
                                        }));
                                      },
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2),
                                        child: Text(
                                          "Admin",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.safeBlockHorizontal * 30,
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: FlatButton(
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Register();
                                            },
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2),
                                        child: Text(
                                          "User",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
