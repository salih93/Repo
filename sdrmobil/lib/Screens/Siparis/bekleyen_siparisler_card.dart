import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';

class BekleyenSiparislerCard extends StatelessWidget {
  const BekleyenSiparislerCard({ Key key, this.root, this.context, this.index }) : super(key: key);
  final BekleyenSiparisGrup root;
  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);
    
    Size size = MediaQuery.of(context).size;

    return  
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,        
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(root.unvan, 
                            style: TextStyle(color: Colors.black, fontSize: size.height * ksiparisoran3, fontWeight: FontWeight.normal,),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01,),                        
                    Row(children: [
                        Expanded(child: Text(root.temsilciadi, 
                            style: TextStyle(color: Colors.black, fontSize: size.height * ksiparisoran3,),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Row(
                      children: [
                        Text("Bekleyen",
                          style: TextStyle(color: Colors.black, fontSize: size.height * ksiparisoran3),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),

              
              Expanded(
                flex: 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Row(children: [
                        Expanded(
                          flex: 3,
                          child:Column(                              
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text("Sip. Tarihi", 
                                style: TextStyle(color: Colors.black, fontSize: size.height * ksiparisoran3,),
                                textAlign: TextAlign.start,                                    
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 4,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(children: [
                                  Text(': '),
                                  Text(DateFormat.yMd('tr_TR').format(root.siparistarihi), 
                                  style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.normal, 
                                    fontSize: size.width * 0.041,),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    

                    SizedBox(height: size.height * 0.0030,),
                    
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text("Sip. No", 
                                style: TextStyle(color: Colors.black, fontSize: size.height * ksiparisoran3,),
                                textAlign: TextAlign.start,                                    
                              ),
                            ],

                          ),
                        ),

                        Expanded(
                          flex: 4,
                          child: 
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Wrap(children: [
                                  Text(': '),
                                  Text(root.siparisno.toString(), style: TextStyle(color: Colors.blue[800],
                                  fontWeight: FontWeight.normal,fontSize: size.width * 0.041,),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    

                    SizedBox(height: size.height * 0.0030,),
                    
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tutar", style: TextStyle(color: Colors.black, fontSize: size.height * ksiparisoran3,),
                                textAlign: TextAlign.start),                                
                              ],
                            ),
                          ),

                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.cover,
                                child: Wrap(
                                  children: [
                                    Text(': '),
                                    Text(mFormat.format(root.tutar) + ' '+format.currencySymbol, 
                                      style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.normal,
                                      fontSize: size.width * 0.041,),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    

                    SizedBox(height: size.height * 0.0030,),
                    
                    Row(children: [
                        Expanded(
                          flex: 3,
                          child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Miktar", 
                                style: TextStyle(color: Colors.black, fontSize: size.height * ksiparisoran3,),
                                textAlign: TextAlign.start,                                    
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 4,
                          child: 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(children: [
                                  Text(': '),
                                  FittedBox(
                                    fit: BoxFit.cover,
                                    child: Text(mFormat.format(root.miktar), 
                                      style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.normal,
                                      fontSize: size.width * 0.041,),
                                    ),
                                  ),                                    
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    

                    SizedBox(height: size.height * 0.0030,),
                  ],
                ),
              ),
              

            ],
          ),

        ],
      );

  }
}