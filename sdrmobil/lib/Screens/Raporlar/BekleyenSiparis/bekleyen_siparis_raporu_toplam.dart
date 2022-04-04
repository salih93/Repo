
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';

class BekleyenSiparisRaporuToplam extends StatelessWidget {
  const BekleyenSiparisRaporuToplam({Key key, this.toplamSTutar }) : super(key: key);
  final double toplamSTutar; 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Locale myLocale = Localizations.localeOf(context);
    
    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);

    return Card(
            color: Colors.teal[800],          
            child:ListTile(
            
              contentPadding: EdgeInsets.only(left: 5.0, right: 0.0),
              title: Column(                
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,        
                children: [                
                  //SizedBox(height: size.height * 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Wrap(                                  
                                children: [                                    
                                  Text("",
                                style: TextStyle(fontSize: size.height * kbekleyensiparisoran, color: Colors.white),),
                                ]
                              ),
                            ],
                          ),
                      ),

                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            
                            Wrap(
                              children: [                                                                   
                                Text("",style: 
                                  TextStyle(fontSize: size.height * kbekleyensiparisoran, color: Colors.white),),
                              ]
                              
                            ),
                            
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Wrap(
                                children: [                                                                    
                                  Text(mFormat.format(toplamSTutar) + ' ' + format.currencySymbol,style: 
                                    TextStyle(fontSize: size.height * kbekleyensiparisoran, color: Colors.white),),
                                ], 
                              ),
                            ),                     
                          ],
                        ),
                      ),
                    ],
                  ),
                
                ],                  
              ),
            ),            
          );
  }
}