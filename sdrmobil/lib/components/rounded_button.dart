import 'package:flutter/material.dart';
import 'package:sdrmobil/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double borderRadius;
  final double marginVertical;
  final double textVertical;
  final double textHorizontal;
  final double fontsize;
  const RoundedButton({
    Key key,
    this.text="",
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    this.borderRadius=29.0,
    this.marginVertical=10.0,
    this.textVertical=20.0,
    this.textHorizontal=40.0,
    this.fontsize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: marginVertical),
      width: size.width * 0.8,
      height: size.height * 0.055,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: TextButton(
          style: TextButton.styleFrom(
            //padding: EdgeInsets.symmetric(vertical: textVertical, horizontal: textHorizontal),            
            backgroundColor: Color(0xff009068),
          ),

          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: fontsize),
          ),
        ),
      ),
    );
  }
}
