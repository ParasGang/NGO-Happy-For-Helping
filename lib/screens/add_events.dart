import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/widgets/navigation_drawer.dart';
import 'package:ngo_happy_to_help/widgets/top_bar.dart';
import 'package:path/path.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AddEvents extends StatefulWidget {
  @override
  _AddEventsState createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String des_error = '', cover = '';
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final name = TextEditingController();
  final date = TextEditingController();
  final description = TextEditingController();

  File _image;
  List<String> imagesList = [];
  var pickedFile;
  var i = 0;

  Future getImage() async {
    try {
      pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = pickedFile;
      });
      await uploadPic();
    } catch (e) {
      print(e);
    }
  }

  Future uploadPic() async {
    try {
      String filename = basename(_image.path);

      StorageReference ref =
          FirebaseStorage.instance.ref().child("events/$filename");

      StorageUploadTask uploadTask = ref.putFile(_image);

      await uploadTask.onComplete;
      String location = await ref.getDownloadURL();
      print(location);
      imagesList.add(location);
      print("Image Uploaded");
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  Future removePic(String id) async {
    print("Hello world");
    try {
      StorageReference storageReference =
          await FirebaseStorage.instance.getReferenceFromUrl(id);

      print("Storage Reference Path :-" + storageReference.path);

      await storageReference.delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: NavigationDrawer(),
        key: _scaffoldKey,
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
                  TopBar(
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Text(
                    'Add Event',
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 11,
                        color: Color(0xff2C317A)),
                  ),
                  Container(
                    margin: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                    padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                    width: SizeConfig.safeBlockHorizontal * 90,
                    decoration: BoxDecoration(
                      color: Color(0xffF1F1F1).withOpacity(0.55),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: name,
                            validator: (val) {
                              return val == "" ? 'Enter Event Name' : null;
                            },
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4),
                            decoration: InputDecoration(
                                hintText: 'Event Name',
                                prefixIcon: Icon(Icons.event)),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 2,
                          ),
                          TextFormField(
                            controller: date,
                            validator: (val) {
                              return val == "" ? 'Enter Event Date' : null;
                            },
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4),
                            decoration: InputDecoration(
                                hintText: 'Date (eg:- 12 June 2020)',
                                prefixIcon: Icon(Icons.date_range)),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 2.5,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                Icons.description,
                                size: SizeConfig.safeBlockHorizontal * 5.8,
                                color: Color(0xff707070),
                              ),
                              SizedBox(
                                  width: SizeConfig.safeBlockHorizontal * 2),
                              Text(
                                "Event Description",
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                                  color: Color(0xff707070),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 1,
                          ),
                          TextFormField(
                            controller: description,
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4),
                            maxLines: 3,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xff707070).withOpacity(0.1),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              des_error,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          // Container(
                          //   height: SizeConfig.safeBlockVertical * 18,
                          //   width: SizeConfig.safeBlockVertical * 25,
                          //   decoration: BoxDecoration(
                          //     color: Colors.grey,
                          //     borderRadius: BorderRadius.circular(15),
                          //   ),
                          //   child: imagesList == null
                          //       ? RaisedButton.icon(
                          //           onPressed: getImage,
                          //           icon: Icon(Icons.add),
                          //           label: FittedBox(
                          //             child: Text(
                          //               "Cover Image",
                          //               style: TextStyle(
                          //                   fontSize:
                          //                       SizeConfig.safeBlockHorizontal *
                          //                           3),
                          //             ),
                          //           ),
                          //         )
                          //       : Image.network(
                          //           imagesList[0],
                          //           fit: BoxFit.fill,
                          //         ),
                          // ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 2,
                          ),
                          Container(
                            height: SizeConfig.safeBlockVertical * 25,
                            child: Row(
                              children: <Widget>[
                                FloatingActionButton(
                                  onPressed: getImage,
                                  child: Icon(Icons.camera_alt),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left:
                                            SizeConfig.safeBlockHorizontal * 2),
                                    height: SizeConfig.safeBlockVertical * 25,
                                    width: SizeConfig.safeBlockHorizontal * 50,
                                    child: imagesList == []
                                        ? null
                                        : ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: imagesList.length,
                                            itemBuilder: (context, index) {
                                              return Stack(
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: SizeConfig
                                                                .safeBlockHorizontal *
                                                            3,
                                                        vertical: SizeConfig
                                                                .safeBlockHorizontal *
                                                            3),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              imagesList[
                                                                  index]),
                                                          fit: BoxFit.fill,
                                                        )),
                                                    height: SizeConfig
                                                            .safeBlockVertical *
                                                        20,
                                                    width: SizeConfig
                                                            .safeBlockHorizontal *
                                                        50,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        setState(() {
                                                          imagesList
                                                              .removeAt(index);
                                                        });
                                                        await removePic(
                                                            imagesList[index]);
                                                      },
                                                      child: CircleAvatar(
                                                        radius: SizeConfig
                                                                .safeBlockHorizontal *
                                                            4,
                                                        backgroundColor:
                                                            Colors.black38,
                                                        child: Icon(
                                                          Icons.clear,
                                                          size: SizeConfig
                                                                  .safeBlockHorizontal *
                                                              6,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
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
                          print(name.text.runtimeType);

                          await Firestore.instance
                              .collection('ngo')
                              .document()
                              .setData(
                            {
                              "name": name.text,
                              "date": date.text,
                              "description": description.text,
                              "images": imagesList,
                              "cover": imagesList[0],
                              "created": FieldValue.serverTimestamp()
                            },
                          );
                        }
                        name.clear();
                        date.clear();
                        description.clear();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.safeBlockHorizontal * 5.5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
