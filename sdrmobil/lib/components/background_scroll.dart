import 'package:flutter/material.dart';

class BackgroundSroll extends StatelessWidget {  
  
  final Widget child;
  const BackgroundSroll({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
        
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(child:
          Container(
            width: double.infinity,
            height: size.height, 
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[              
                child,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
