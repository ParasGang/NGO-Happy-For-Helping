import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/widgets/navigation_drawer.dart';
import 'package:ngo_happy_to_help/widgets/top_bar.dart';

class ThoughtsUpload extends StatefulWidget {
  @override
  _ThoughtsUploadState createState() => _ThoughtsUploadState();
}

class _ThoughtsUploadState extends State<ThoughtsUpload> {
  bool photo = false;
  File _image;
  var pickedFile;
  String location;
  var _thought = TextEditingController();

  Future getImage() async {
    try {
      pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = pickedFile;
      });
    } catch (e) {
      print(e);
    }
  }

  Future uploadPic() async {
    try {
      String filename = basename(_image.path);

      StorageReference ref =
          FirebaseStorage.instance.ref().child("thoughts/$filename");

      StorageUploadTask uploadTask = ref.putFile(_image);

      await uploadTask.onComplete;
      location = await ref.getDownloadURL();

      print("Image Uploaded");
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (photo == false) {
              await getImage();
              photo = true;
              setState(() {});
            } else {
              photo = false;
              setState(() {});
            }
          },
          child: photo == false ? Icon(Icons.photo) : Icon(Icons.edit),
        ),
        key: _scaffoldKey,
        drawer: NavigationDrawer(),
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
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Column(
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
                  'Add Thought',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 11,
                      color: Color(0xff2C317A)),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 3.7,
                ),
                photo != true
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Form(
                          key: _key,
                          child: TextFormField(
                            validator: (value) {
                              return value == "" ? "Enter Thought" : null;
                            },
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4),
                            controller: _thought,
                            maxLines: 4,
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
                        ),
                      )
                    : Container(
                        padding:
                            EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                        height: SizeConfig.safeBlockVertical * 30,
                        width: SizeConfig.safeBlockHorizontal * 90,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                              image: FileImage(_image), fit: BoxFit.fill),
                        ),
                      ),
                SizedBox(height: SizeConfig.safeBlockVertical * 3),
                Container(
                  width: SizeConfig.safeBlockHorizontal * 35,
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
                      if (photo == false) {
                        if (_key.currentState.validate()) {
                          print("Hello");

                          await Firestore.instance
                              .collection("thought")
                              .document()
                              .setData({
                            'text': _thought.text,
                            'image': "",
                            'created': FieldValue.serverTimestamp(),
                          });
                          Navigator.of(context).pop();
                        }
                      } else {
                        await uploadPic();
                        print("Hello PHOTO");
                        await Firestore.instance
                            .collection("thought")
                            .document()
                            .setData({
                          'text': "",
                          'image': location,
                          'created': FieldValue.serverTimestamp(),
                        });
                        Navigator.of(context).pop();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Upload",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.safeBlockHorizontal * 5),
                      ),
                    ),
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
