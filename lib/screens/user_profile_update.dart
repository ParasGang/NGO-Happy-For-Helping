import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileUpdate extends StatefulWidget {
  final nameA, phoneA, photoA, uidA;
  UserProfileUpdate({this.nameA, this.phoneA, this.photoA, this.uidA});
  @override
  _UserProfileUpdateState createState() => _UserProfileUpdateState();
}

class _UserProfileUpdateState extends State<UserProfileUpdate> {
  var uid;
  File _image;
  var avatar =
      "https://firebasestorage.googleapis.com/v0/b/happy-for-helping.appspot.com/o/avatar.png?alt=media&token=97a5b8e2-a4f2-493a-911f-c7d1ae07c3e8";
  var oldPhoto = "";
  var pickedFile;
  Future getImage() async {
    try {
      var pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = pickedFile;
      });
      await uploadPic();
      print(avatar);
      print(oldPhoto);
      if (oldPhoto != null) {
        await removePic(oldPhoto);
      }
    } catch (e) {
      print(e);
    }
  }

  Future removePic(String id) async {
    try {
      StorageReference storageReference =
          await FirebaseStorage.instance.getReferenceFromUrl(id);

      print(storageReference.path);

      await storageReference.delete();
    } catch (e) {
      print(e);
    }
  }

  Future uploadPic() async {
    String filName = basename(_image.path);
    StorageReference reference = FirebaseStorage.instance.ref().child(filName);
    StorageUploadTask uploadTask = reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String location = await reference.getDownloadURL();
    oldPhoto = photo.text;
    photo.text = location;
    setState(() {
      print("Image Uploaded");
    });
  }

  bool _isloading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var phone = TextEditingController();
  var cpassword = TextEditingController();
  var photo = TextEditingController();
  @override
  void initState() {
    name.text = widget.nameA;
    phone.text = widget.phoneA;
    photo.text = widget.photoA;
    uid = widget.uidA;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
                          "Update Profile",
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 7,
                            color: Color(0xff2D2B2B),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 1,
                          width: double.infinity,
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
                                  height: SizeConfig.safeBlockVertical * 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      backgroundImage: photo.text == ""
                                          ? AssetImage(
                                              "assets/images/avatar.png")
                                          : NetworkImage(photo.text),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              SizeConfig.safeBlockVertical * 6),
                                      child: IconButton(
                                        icon: Icon(Icons.photo),
                                        onPressed: getImage,
                                      ),
                                    )
                                  ],
                                ),
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
                                await Firestore.instance
                                    .collection("users")
                                    .document(uid)
                                    .updateData({
                                  "name": name.text,
                                  "phone": phone.text,
                                  "photo": photo.text
                                });
                                SharedPreferences _prefs =
                                    await SharedPreferences.getInstance();
                                _prefs.setString("name", name.text);
                                _prefs.setString("phone", phone.text);
                                _prefs.setString("photo", photo.text);
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Profile Updated Successfully'),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Update",
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
