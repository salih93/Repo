
import 'package:flutter/material.dart';
import 'package:sdrmobil/constants.dart';

class MyZiyaretCard extends StatelessWidget {
  const MyZiyaretCard({
    Key key,
    this.textField,
    this.textColor,
    this.icons,    
    this.onClick
  }) : super(key: key);
  final String textField;
  final Widget icons;
  final Color textColor;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      child: ListTile(
        title: Row(children: [
          Expanded(flex: 2,child: 
            Column(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [                
                  Center(
                    child: icons                    
                  ),
                ],
            ),
          ),

          Expanded(flex: 9,
            child: Padding(padding: EdgeInsets.only(left: 20),
              child:Column(              
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  TextButton(child: Text(textField,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: textColor,
                        fontSize: size.height * kcarihareketoran,
                      ),
                    ),
                    onPressed: onClick,
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex:1, 
            child:Padding(padding: EdgeInsets.only(right: 10),
              child:Column(              
                mainAxisAlignment:MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [                  
                ],
              ),
            ),
          ),
          SizedBox(height: size.height * 0.075),
        ],
      ),
      dense: true,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ],
      ),
      onTap: onClick,
      ),
    );
  }
}