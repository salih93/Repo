import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:sdrmobil/constants.dart';

class RaporlarAnaMenuCard extends StatelessWidget {  
  const RaporlarAnaMenuCard({
    Key key,
    @required this.size,
    this.butonText,
    this.onPressed,
    this.icon,
    this.reverse,
    this.color
  }) : super(key: key);
  final Size size;
  final String butonText;
  final Function onPressed;
  final Widget icon;
  final int reverse;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,              
          children: [
            SizedBox(
              width: size.width * 0.50,
              child: TextButton(
                child: Column( // Replace with a Row for horizontal icon + text
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[                    
                    reverse==1 ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: icon,
                    ):icon,
                    Text(butonText, style: TextStyle(color: Colors.white, fontSize: size.height * kRaporDetayOran),textAlign: TextAlign.center,),
                  ],
                ),
                
                style: ButtonStyle(                                            
                  backgroundColor: MaterialStateProperty.all(Color(0xff009068)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.white)
                    ),
                  ),                      
                ),
                onPressed: onPressed,

              ),
            ),
          ],
        ),
      ),
      
    );
  }
}