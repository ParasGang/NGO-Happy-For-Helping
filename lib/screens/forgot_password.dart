import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var error = "";

  var email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 3,
                    width: double.infinity,
                  ),
                  FittedBox(
                    child: Text(
                      'Password Reset',
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 11,
                          color: Color(0xff2C317A)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
                    child: Text(
                      'A password reset link will be send to your email address.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 5,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal * 7),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: email,
                        validator: (value) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(value))
                            return 'Enter Valid Email';
                          else
                            return null;
                        },
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 3.8),
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(
                            Icons.mail,
                            size: SizeConfig.safeBlockHorizontal * 5.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 3,
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
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email.text);
                            Navigator.of(context).pop();
                          } catch (e) {
                            print(e);
                            setState(() {
                              error = "You are not a registered User!";
                            });
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: FittedBox(
                          child: Text(
                            "Send Link",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.safeBlockHorizontal * 5.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1,
                  ),
                  Text(
                    error,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: SizeConfig.safeBlockHorizontal * 4),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
