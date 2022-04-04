import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/models/Siparis/gunluk_siparis.dart';

class GunlukSiparisListesiCard extends StatelessWidget {
  const GunlukSiparisListesiCard({ Key key, @required this.item, this.index }) : super(key: key);

  final GunlukSiparis item;
  final int index;

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
    final nFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "",symbol: "", decimalDigits: 0);
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);
    
    initializeDateFormatting(myLocale.languageCode);
    Size size = MediaQuery.of(context).size;    

      return Column(
        children: [
          SizedBox(height: size.height * 0.005,),
          Card(          
            child:ListTile(
            //tileColor: (index % 2)>0 ? Colors.grey[200]:Colors.white,
            contentPadding: EdgeInsets.only(left: 5.0, right: 0.0),
            title: Column(                
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,        
              children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Expanded(                            
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.cover,
                                child: Wrap(
                                  children: [                                                                                                           
                                    Text(item.malzemeKodu + ' / ', style: TextStyle(fontSize: size.height * kgunluksiparisoran, color: Colors.blue[800]),),
                                    Text(item.malzemeAdi, style: TextStyle(fontSize: size.height * kgunluksiparisoran, color: Colors.blue[800]),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                  ),
                  SizedBox(height: size.height * 0.01,),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Wrap(
                                children: [                                                                        
                                  Text(nFormat.format(item.miktar),style: TextStyle(fontSize: size.height * kgunluksiparisoran, color: Colors.blue[800]),),
                                  Text(' ',style: TextStyle(fontSize: size.height * kgunluksiparisoran),),  
                                  Text(item.bazBirim,style: TextStyle(fontSize: size.height * kgunluksiparisoran, color: Colors.blue[800]),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Wrap(
                                children: [                                
                                  Text(mFormat.format(item.satirTutari) + ' '+format.currencySymbol,style: TextStyle(fontSize: size.height * kgunluksiparisoran, color: Colors.blue[800]),),
                                ],
                              ),
                            ),                    
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Wrap(
                                children: [                                
                                  Text(item.depoAdi,style: TextStyle(fontSize: size.height * kgunluksiparisoran, color: Colors.blue[800]),),
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
        
          ),
        ],
      );
      
                
  }
}