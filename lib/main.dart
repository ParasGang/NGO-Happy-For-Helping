import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngo_happy_to_help/screens/events.dart';
import 'package:ngo_happy_to_help/screens/home_page.dart';
import 'package:ngo_happy_to_help/screens/login.dart';
import 'package:ngo_happy_to_help/screens/register.dart';
import 'package:ngo_happy_to_help/service/user_handling.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/entry_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var uid = _prefs.getString("uid");
  runApp(MyApp(
    uid: uid,
  ));
}

class MyApp extends StatelessWidget {
  final uid;
  MyApp({this.uid});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    //SizeConfig().init(context);
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
      )),
      debugShowCheckedModeBanner: false,
      home: uid == null ? Login() : HomePage(),
    );
  }
}
