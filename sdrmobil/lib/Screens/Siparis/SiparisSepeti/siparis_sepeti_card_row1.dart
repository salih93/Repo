import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir_list.dart';
class SiparisSepetiCardRow1 extends StatelessWidget {
  const SiparisSepetiCardRow1({Key key, this.item }) : super(key: key);
  final SiparisSatirList item;

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
    Size size = MediaQuery.of(context).size;
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);
    
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [                              
          Expanded(flex: 3,                                
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(flex: 2,          
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text("Miktar:", style: TextStyle(fontSize: size.height * ksiparisoran5),),
                        ],
                      ),
                    ),
                    
                    Expanded(flex: 1,          
                      child:Column(children: [
                        FittedBox(
                            fit: BoxFit.contain,
                            child: Text(item.miktar.toStringAsFixed(0), 
                              style: TextStyle(color: Colors.blue[800], fontSize: size.height * ksiparisoran5),
                              textAlign: TextAlign.end,
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

          Expanded(flex: 2,                                
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(children: [
                  Text("Birim:", style: TextStyle(fontSize: size.height * ksiparisoran5),),
                  Text(item.bazbirim, 
                          style: TextStyle(color: Colors.blue[800], fontSize: size.height * ksiparisoran5),
                          textAlign: TextAlign.end,),
                ],),                                  
              ],
            ),
          ),


          Expanded(flex: 3,                                
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(flex: 1,          
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Fiyat :", style: TextStyle(fontSize: size.height * ksiparisoran5),),
                        ],
                      ),
                    ),

                    Expanded(flex: 1,          
                      child:Column(children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(mFormat.format(item.birimfiyat)+' '+format.currencySymbol, style: TextStyle(color: Colors.blue[800], fontSize: size.height * ksiparisoran5),
                            textAlign: TextAlign.end,),
                        ),
                        ],
                      ), 
                    ),
                  ],
                ),                                      
                
              ],
            ),
          ),

          
        
        ],
      );

  }
}