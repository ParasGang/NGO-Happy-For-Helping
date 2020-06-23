import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  String email, password;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.safeBlockVertical * 10,
            ),
            Text(
              "Welcome Admin",
              style: TextStyle(
                  color: Color(0xff2D2B2B),
                  fontSize: SizeConfig.safeBlockHorizontal * 6),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 4,
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 4),
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal * 8),
              width: SizeConfig.safeBlockHorizontal * 84,
              decoration: BoxDecoration(
                  color: Color(0xfff2f2f2).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                        color: Color(0xff2C317A),
                        fontSize: SizeConfig.safeBlockHorizontal * 4.5),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  TextField(
                    onChanged: (value) => email = value,
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 3.8),
                    decoration: InputDecoration(
                      hintText: "Username",
                      prefixIcon: Icon(
                        Icons.mail,
                        size: SizeConfig.safeBlockHorizontal * 5.5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1,
                  ),
                  TextField(
                    obscureText: true,
                    onChanged: (value) => password = value,
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 3.8),
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        size: SizeConfig.safeBlockHorizontal * 5.5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Color(0xff2C317A),
                          fontSize: SizeConfig.safeBlockHorizontal * 3.5),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 5,
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
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.safeBlockHorizontal * 5.5),
                  ),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/a.png'),
                      fit: BoxFit.fill)),
            ),
          ],
        ),
      ),
    );
  }
}
