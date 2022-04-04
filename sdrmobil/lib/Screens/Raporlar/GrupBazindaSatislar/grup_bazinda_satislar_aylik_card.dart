import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/models/Raporlar/musteri_mal_analiz_ay_toplam.dart';

class GrupBazindaSatislarAylikCard extends StatelessWidget {
  const GrupBazindaSatislarAylikCard({ Key key, @required this.item, 
              this.index
            }) : super(key: key);

  final MusteriMalAnaliziAyToplam item;
  final int index;
  
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
    final nFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "",symbol: "", decimalDigits: 0);
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);
    //final RaporController _controller =Get.find();
    
    
    initializeDateFormatting(myLocale.languageCode);
    Size size = MediaQuery.of(context).size;    

      return Column(
        children: [
          Card(          
            child:ListTile(
            //tileColor: (index % 2)>0 ? Colors.grey[200]:Colors.white,
            contentPadding: EdgeInsets.only(left: 5.0, right: 0.0),
            title: 
              Column(                
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
                              fit: BoxFit.contain,
                              child: Text(item.musteriKodu + " / " + item.unvan ,style: TextStyle(fontSize: size.height * kGrupBazindaSatislarOran),),
                            )
                                                  
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
                            Text(item.ay1, style: TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [                                
                                Text(nFormat.format(item.ay1netMiktar),style: 
                                  TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.blue[800]),),
                              ],
                            ),                                                    
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                // Text("Net Tutar", style: TextStyle(fontSize: size.width * KGRUPBAZINDASATISLARORAN),),
                                // Text(": ", style: TextStyle(fontSize: size.width * KGRUPBAZINDASATISLARORAN),),
                                Text(mFormat.format(item.ay1netTutar)+ ' '+format.currencySymbol,style: 
                                  TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.blue[800]),),
                              ],
                            ),                                                    
                          ],
                        ),
                      ),
                    ]                    
                  ),
                  SizedBox(height: size.height * 0.01,),
                  
                  item.ay2!="" ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.ay2, style: TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [                                
                                Text(nFormat.format(item.ay2netMiktar),style: 
                                  TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.blue[800]),),
                              ],
                            ),                                                    
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                Text(mFormat.format(item.ay2netTutar)+ ' '+format.currencySymbol,style: 
                                  TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.blue[800]),),
                              ],
                            ),                                                    
                          ],
                        ),
                      ),
                      
                    ],                    
                  ):SizedBox(height: size.height * 0.0005,),
                  
                  item.ay2=="" ? SizedBox(height: size.height * 0.0005,):SizedBox(height: size.height * 0.01,),
                  
                  item.ay3!="" ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.ay3, style: TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [                                
                                Text(nFormat.format(item.ay3netMiktar),style: 
                                  TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.blue[800]),),
                              ],
                            ),                                                    
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                Text(mFormat.format(item.ay3netTutar) + ' '+format.currencySymbol,style: 
                                  TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.blue[800]),),
                              ],
                            ),                                                    
                          ],
                        ),
                      ),
                    ]
                  ):SizedBox(height: size.height * 0.0005,),

                  item.ay3=="" ? SizedBox(height: size.height * 0.0005,):SizedBox(height: size.height * 0.01,),

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
                            Text("Total", style: TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [                                
                                Text(nFormat.format(item.ay1netMiktar + item.ay2netMiktar + item.ay3netMiktar),style: 
                                  TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.blue[800]),),
                              ],
                            ),                                                    
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                Text(mFormat.format(item.ay1netTutar + item.ay2netTutar + item.ay3netTutar) + ' '+format.currencySymbol,style: 
                                  TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.blue[800]),),
                              ],
                            ),                                                    
                          ],
                        ),
                      ),
                    ]
                  ),
                  

                ],
              ),
            ),            
          ),

        ],
      );
      
                
  }
}