import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/screens/entry_page.dart';
import 'package:ngo_happy_to_help/screens/events.dart';
import 'package:ngo_happy_to_help/screens/home_page.dart';
import 'package:ngo_happy_to_help/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHandling {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Widget handleAuth() {
    return StreamBuilder(
        stream: _auth.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return HomePage();
          }
          return Login();
        });
  }

  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user.uid != null) {
        await currentUserData();
      }
      return user.uid;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      return user.uid;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future uploadUserData(String phone, String uid, String name, String email,
      String token, int role) async {
    CollectionReference _ref = Firestore.instance.collection("users");
    try {
      _ref.document(uid).setData({
        "name": name,
        "email": email,
        "device_token": token,
        "role": role,
        "phone": phone,
      });
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future currentUserData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    CollectionReference _ref = Firestore.instance.collection('users');
    FirebaseUser user = await _auth.currentUser();

    var uid = user.uid;
    print(uid);
    await _ref.document(uid).get().then((DocumentSnapshot snapshot) {
      print(snapshot.data['name']);
      print(snapshot.data['email']);
      print(snapshot.data['role']);
      _pref.setString('uid', uid);
      _pref.setString('name', snapshot.data['name']);
      _pref.setString('email', snapshot.data['email']);
      _pref.setInt('role', snapshot.data['role']);
      _pref.setString('photo', snapshot.data['photo']);
      _pref.setString('phone', snapshot.data['phone']);
    }).catchError((err) {
      print(err);
    });
  }
}
