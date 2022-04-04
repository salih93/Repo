import 'package:flutter/material.dart';
import 'package:sdrmobil/constants.dart';

class AktarimGostergesiCard2 extends StatelessWidget {
  final String baslik;  
  final String value;

  final Color baslikArkaplanRengi;
  const AktarimGostergesiCard2({
    Key key,
    this.baslik,    
    this.baslikArkaplanRengi,    
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Container(      
      child: Card(
        shadowColor: baslikArkaplanRengi,      
        child:Column(                  
          children: [
            ListTile(            
              contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              //tileColor: baslikArkaplanRengi,              
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.06,
                    color: baslikArkaplanRengi,
                    child: Row(                                  
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(baslik, 
                              style: TextStyle(fontSize: size.height * kaktarimbasoran, color: Colors.white),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),

                  Container(
                    height: size.height * 0.04,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [                  
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,                  
                          children: [
                            Text(value, 
                              style: TextStyle( fontSize: size.height * kaktarimoran, color: Colors.black54),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),
            
            // ListTile(
            //   shape: RoundedRectangleBorder(
            //     side: BorderSide(color: baslikArkaplanRengi, width: 1),
            //   ),
            //   title: 
            // ),

          ],
        ),
      ),
    );
  }
}