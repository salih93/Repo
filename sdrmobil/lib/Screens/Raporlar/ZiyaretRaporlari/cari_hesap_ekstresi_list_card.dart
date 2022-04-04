
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/models/Cari/cari_hesap_ekstresi.dart';

class CariHesapEkstreCard extends StatelessWidget {
  const CariHesapEkstreCard({ Key key, @required this.ekstre}) : super(key: key);
  final CariHesapEkstresi ekstre;
  
  
  @override
  Widget build(BuildContext context) {
    
    Locale myLocale = Localizations.localeOf(context);
    initializeDateFormatting(myLocale.languageCode);

    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
    initializeDateFormatting(myLocale.languageCode);
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);
    
    Size size = MediaQuery.of(context).size;
      return Card(                    
           child:ListTile(
            
            title:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Row(                                  
                    children: [
                      Expanded(flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [                                                              
                            Wrap(
                              children: [
                                Text('Fiş No', style: TextStyle(fontSize:size.height * ktahsilatoran4),),                                
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [                                                              
                            Wrap(
                              children: [                                
                                Text(": " + ekstre.fisNo.toString().trim(), style: TextStyle(fontSize:size.height * ktahsilatoran4, color: Colors.blue[800])),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                Text('Evrak Tarihi', style: TextStyle(fontSize:size.height * ktahsilatoran4),),                                
                              ],
                            ),

                          ],
                        ),
                      ),

                      Expanded(flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [                                
                                Text(': ', style: TextStyle(fontSize:size.height * ktahsilatoran4),),
                                Text(DateFormat.yMd('tr_TR').format(ekstre.evrakTarihi), style: TextStyle(fontSize:size.height * ktahsilatoran4, color: Colors.blue[800])),
                              ],
                            ),

                          ],
                        ),
                      ),



                    ],
                  ),
                  SizedBox(height: size.height * 0.005,),
                  Row(
                      children: [
                      Expanded(flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                Text('R.Belge No', style: TextStyle(fontSize:size.height * ktahsilatoran4),),
                              ],
                            ),                              
                          ],
                        ),
                      ),

                      Expanded(flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Wrap(
                                children: [
                                  Text(': ', style: TextStyle(fontSize:size.height * ktahsilatoran4),),                                
                                  Text(ekstre.resmiBelgeNo, style: TextStyle(fontSize:size.height * ktahsilatoran4, color: Colors.blue[800])),
                                ],
                              ),
                            ),                              
                          ],
                        ),
                      ),


                      Expanded(flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Wrap(
                                children: [
                                  Text('Fiş Türü', style: TextStyle(fontSize:size.height * ktahsilatoran4),),                                  
                                ],
                              ),
                            ),                          
                          ],
                        ),
                      ),

                      Expanded(flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Wrap(
                                children: [
                                  Text(': ', style: TextStyle(fontSize:size.height * ktahsilatoran4),),
                                  Text(ekstre.fisturu, style: TextStyle(fontSize:size.height * ktahsilatoran4, color: Colors.blue[800])),
                                ],
                              ),
                            ),                          
                          ],
                        ),
                      ),
                      


                    ],
                  ),                  
                  SizedBox(height: size.height * 0.005,),


                  Row(
                      children: [
                      Expanded(flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Wrap(
                                children: [                                
                                  Text('Borc', style: TextStyle(fontSize:size.height * ktahsilatoran4),),                                  
                                ],
                              ),
                            ),                          
                          ],
                        ),
                      ),

                      Expanded(flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Wrap(
                                children: [
                                  Text(': ', style: TextStyle(fontSize:size.height * ktahsilatoran4),),
                                  Text(mFormat.format(ekstre.borc) + ' '+format.currencySymbol, style: TextStyle(fontSize:size.height * ktahsilatoran4, color: Colors.blue[800]),),
                                ],
                              ),
                            ),                          
                          ],
                        ),
                      ),


                      Expanded(flex: 3,
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Wrap(
                                children: [
                                  Text('Alacak', style: TextStyle(fontSize:size.height * ktahsilatoran4),),                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(flex: 4,
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Wrap(
                                children: [                                  
                                  Text(': ', style: TextStyle(fontSize:size.height * ktahsilatoran4),),
                                  Text(mFormat.format(ekstre.alacak) + ' '+format.currencySymbol, style: TextStyle(fontSize:size.height * ktahsilatoran4, color: Colors.blue[800]),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),                  
                  SizedBox(height: size.height * 0.005,),
                ],
                
              ),
           
                                                
            subtitle: Column(              
              children: [                
                Row(                  
                  children: [

                    Expanded(flex: 3,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [                              
                              Text('Açıklama', style: TextStyle(fontSize:size.height * ktahsilatoran4),),
                              Text(': ', style: TextStyle(fontSize:size.height * ktahsilatoran4),),
                            ],
                          ),
                        ],
                      ),                     
                    ),
                    Expanded(flex: 4,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text(': ', style: TextStyle(fontSize:size.height * ktahsilatoran4),),
                            ],
                          ),
                        ],
                      ),                     
                    ),

                    Expanded(flex: 7,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [                          
                          Text(ekstre.aciklama.toString(),style: TextStyle(fontSize:size.height * ktahsilatoran4),),
                        ],
                      ),          
                    ),
                    
                  ],
                )

              ],
            ),
                    
        ),
      );
                
  }
}