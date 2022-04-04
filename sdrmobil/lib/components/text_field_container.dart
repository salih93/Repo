import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),      
      width: size.width * 0.8,
      height: size.height * 0.055,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 143, 104, 0.10),
        borderRadius: BorderRadius.circular(29),        
      ),
      child: child,
    );
  }
}
