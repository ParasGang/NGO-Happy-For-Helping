import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/screens/login.dart';

class EntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SizedBox(height: 50),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset(
                'assets/images/charity.png',
                fit: BoxFit.fill,
              )),
          SizedBox(
            height: 25,
            width: double.infinity,
          ),
          Text(
            "Welcome To",
            style: TextStyle(
                fontSize: 26,
                color: Color(0xff707070).withOpacity(0.8),
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
            width: double.infinity,
          ),
          Text(
            "Happy To Help",
            style: TextStyle(
                fontSize: 42,
                color: Color(0xff2C317A),
                fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: 35,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
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
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Create Account",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xff707070)),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return Login();
                }), (route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/a.png'),
                    fit: BoxFit.fill)),
          )
        ],
      )),
    );
  }
}
