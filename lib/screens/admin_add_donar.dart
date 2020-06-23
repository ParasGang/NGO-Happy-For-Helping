import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';
import 'package:ngo_happy_to_help/service/database.dart';
import 'package:ngo_happy_to_help/widgets/navigation_drawer.dart';
import 'package:ngo_happy_to_help/widgets/top_bar.dart';

class AddDonar extends StatefulWidget {
  @override
  _AddDonarState createState() => _AddDonarState();
}

class _AddDonarState extends State<AddDonar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var name = TextEditingController();

  var amount = TextEditingController();

  bool pay = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavigationDrawer(),
        key: _scaffoldKey,
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
                  TopBar(
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical * 3),
                  Text(
                    'Add Donar',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 10.5,
                      color: Color(0xff2C317A),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3.7,
                  ),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 80,
                    //height: SizeConfig.safeBlockVertical * 50,
                    padding: EdgeInsets.all(35),
                    decoration: BoxDecoration(
                        color: Color(0xfff2f2f2).withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Add Donation Details",
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5.5,
                                color: Color(0xff707070)),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 3.7,
                          ),
                          TextFormField(
                            validator: (value) {
                              return value.length < 3
                                  ? "Enter a Valid Name"
                                  : null;
                            },
                            controller: name,
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 3.8),
                            decoration: InputDecoration(
                              hintText: "Donar Name",
                              prefixIcon: Icon(
                                Icons.person,
                                size: SizeConfig.safeBlockHorizontal * 5.5,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2.5,
                          ),
                          TextFormField(
                            validator: (value) {
                              return value.length == null
                                  ? "Enter a Valid Amount"
                                  : null;
                            },
                            controller: amount,
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 3.8),
                            decoration: InputDecoration(
                              hintText: "Donation Amount",
                              prefixIcon: Icon(
                                Icons.done_all,
                                size: SizeConfig.safeBlockHorizontal * 5.5,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Payment",
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 5),
                              ),
                              SizedBox(
                                width: SizeConfig.safeBlockHorizontal * 4,
                              ),
                              Transform.scale(
                                scale: 2.0,
                                child: Switch(
                                  value: pay,
                                  onChanged: (bool e) {
                                    pay = e;
                                    setState(() {});
                                    print(pay);
                                  },
                                  activeColor: Colors.green[600],
                                  inactiveThumbColor: Colors.red[600],
                                  activeTrackColor: Colors.green[200],
                                  inactiveTrackColor: Colors.red[200],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
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
                        if (_formKey.currentState.validate()) {
                          Database db = Database();
                          await db.donarListUpload(name.text, amount.text, pay);
                          name.clear();
                          amount.clear();

                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text('Donar Added Successfully'),
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.safeBlockHorizontal * 5),
                        ),
                      ),
                    ),
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
