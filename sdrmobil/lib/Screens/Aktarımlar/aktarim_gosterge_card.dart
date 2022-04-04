import 'package:flutter/material.dart';
import 'package:sdrmobil/constants.dart';

class AktarimGostergesiCard extends StatelessWidget {
  final String baslik;
  final String altBaslik1;
  final String altBaslik2;
  final int altBaslikvalue1;
  final int altBaslikvalue2;

  final Color baslikArkaplanRengi;
  const AktarimGostergesiCard({
    Key key,
    this.baslik,    
    this.baslikArkaplanRengi,
    this.altBaslik1,
    this.altBaslik2,
    this.altBaslikvalue1,
    this.altBaslikvalue2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Card(            
      shadowColor: baslikArkaplanRengi,
      child:Column(
        children: [          
          ListTile(
            //tileColor: baslikArkaplanRengi,
            
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
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
                SizedBox(height: size.height * 0.015,),

                Container(
                  height: size.height * 0.04,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(children: [
                              Text(altBaslik1, 
                                style: TextStyle( fontSize: size.height * kaktarimoran, color: Colors.black54),
                              ),
                              Text(altBaslikvalue1.toString(), 
                                style: TextStyle( fontSize: size.height * kaktarimoran, color: Colors.black54),
                              ),
                            ],
                          ),
                            
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(children: [
                              Text(altBaslik2, 
                                style: TextStyle(fontSize: size.height * kaktarimoran, color: Colors.black54),
                              ),

                              Text(altBaslikvalue2.toString(), 
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
                

              ],
            ),
          ),
          
          // ListTile(
          //   shape: RoundedRectangleBorder(
          //     side: BorderSide(color: baslikArkaplanRengi, width: 0.5),
          //   ),
          //   title: 
          // ),



        ],
      ),
    );
  }
}