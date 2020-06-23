import 'package:flutter/material.dart';
import 'package:ngo_happy_to_help/models/size_config.dart';

class TopBar extends StatelessWidget {
  final Function onTap;
  TopBar({this.onTap});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.safeBlockVertical * 2,
        left: SizeConfig.safeBlockVertical * 2,
        right: SizeConfig.safeBlockVertical * 2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.menu,
              color: Color(0xff2C317A),
              size: SizeConfig.safeBlockVertical * 4.5,
            ),
          ),
          Container(
            child: AspectRatio(aspectRatio: 1 / 1),
            height: SizeConfig.safeBlockVertical * 8.5,
            decoration: ShapeDecoration(
                shape: CircleBorder(
                  side: BorderSide(
                    color: Color(0xff2C317A).withOpacity(0.5),
                    width: 5,
                  ),
                ),
                image: DecorationImage(
                    image: AssetImage('assets/images/charity.png'))),
          )
        ],
      ),
    );
  }
}
