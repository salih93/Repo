import 'package:flutter/material.dart';
import 'package:sdrmobil/constants.dart';

class Background extends StatelessWidget {  
  final int veritabaniSifirla;
  final Widget child;
  final Function onTap;
  const Background({
    Key key,
    @required this.child,
    this.veritabaniSifirla=0,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    
    return SizedBox(
      height: screenHeight - keyboardHeight,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            //alignment: Alignment.center,
            children: <Widget>[              
              Center(
                // alignment: Alignment.center,
                // height: size.height * 0.95,
                // width: size.width * 0.98,
                child:child,                
              ),

              veritabaniSifirla==1 ? Container(
                padding: const EdgeInsets.all(5.0),
                alignment: Alignment.bottomRight,                
                child: GestureDetector(
                    child: Text("Veritabanı sıfırla", 
                    style: TextStyle(decoration: TextDecoration.underline, 
                        color: Colors.black26,
                        fontSize: size.height * kVeritabaniSifirlaOran
                      ),

                    ),
                    onTap: onTap,
                  ),        
              ):SizedBox(height: size.height * 0.001,),

            ],
          ),
        ),
      ),
    );
  }
}
