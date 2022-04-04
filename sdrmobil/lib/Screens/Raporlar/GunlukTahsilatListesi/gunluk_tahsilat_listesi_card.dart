import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/rapor_controller.dart';
import 'package:sdrmobil/models/Raporlar/gunluk_tahsilat.dart';

class GunlukTahsilatListesiCard extends StatelessWidget {
  const GunlukTahsilatListesiCard({ Key key, @required this.item, this.index, this.toplamYaz }) : super(key: key);

  final GunlukTahsilat item;
  final int index;
  final int toplamYaz;

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
    
    final RaporController _controller =Get.find();
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
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Wrap(
                                    children: [                                    
                                      Text("Cari",style: TextStyle(fontSize: size.height * kguntahsilatoran),),
                                      Text("  : ",style: TextStyle(fontSize: size.height * kguntahsilatoran),),                                 
                                      Text(item.cariKodu + ' ', style: TextStyle(fontSize: size.height * kguntahsilatoran, color: Colors.blue[800]),),
                                      Text(item.cariUnvan + ' ', style: TextStyle(fontSize: size.height * kguntahsilatoran, color: Colors.blue[800]),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Wrap(
                                    children: [                                    
                                      Text("Fiş No",style: TextStyle(fontSize: size.height * kguntahsilatoran),),
                                      Text(": ",style: TextStyle(fontSize: size.height * kguntahsilatoran),),
                                      Text(item.fisNo,style: TextStyle(fontSize: size.height * kguntahsilatoran, color: Colors.blue[800]),),
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
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Wrap(
                                  children: [                                    
                                    Text("Fiş T.",style: TextStyle(fontSize: size.height * kguntahsilatoran),),
                                    Text(": ",style: TextStyle(fontSize: size.height * kguntahsilatoran),),
                                    Text(item.fisTuru,style: TextStyle(fontSize: size.height * kguntahsilatoran, color: Colors.blue[800]),),  
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Wrap(
                                  children: [
                                    Text("Tarih",style: TextStyle(fontSize: size.height * kguntahsilatoran),),
                                    Text(": ",style: TextStyle(fontSize: size.height * kguntahsilatoran),),
                                    Text(DateFormat('dd-MM-yyyy').format(item.tarih),style: TextStyle(fontSize: size.height * kguntahsilatoran, color: Colors.blue[800]),),
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
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Wrap(
                                  children: [
                                    Text("Kasa",style: TextStyle(fontSize: size.height * kguntahsilatoran),),
                                    Text(": ",style: TextStyle(fontSize: size.height * kguntahsilatoran),),
                                    Text(item.sorumlu,style: TextStyle(fontSize: size.height * kguntahsilatoran, color: Colors.blue[800]),),                                      
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Wrap(
                                  children: [
                                    Text("Alacak",style: TextStyle(fontSize: size.height * kguntahsilatoran),),
                                    Text(": ",style: TextStyle(fontSize: size.height * kguntahsilatoran),),
                                    Text(mFormat.format(item.tlAlacak) + ' '+format.currencySymbol,style: TextStyle(fontSize: size.height * kguntahsilatoran, color: Colors.blue[800]),),
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

          toplamYaz==1 ? Card(
            color: Colors.teal[800],
            child:ListTile(                    
              contentPadding: EdgeInsets.only(left: 5.0, right: 0.0),
              title: Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("" ,style: TextStyle(fontSize: size.height * kguntahsilatoran,),),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 2,                      
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Wrap(
                            children: [
                              //aynı hizadan yazsın diye beyaz bir yazı görünmeyecek.
                              Text("Toplam",style: TextStyle(fontSize: size.height * kguntahsilatoran, color:Colors.white),),
                              Text(": ",style: TextStyle(fontSize: size.height * kguntahsilatoran, color:Colors.white),),
                              Text(mFormat.format(_controller.gunlukTahsilatToplam.value) + ' '+format.currencySymbol,
                                style: TextStyle(fontSize: size.height * kguntahsilatoran, color: Colors.white),),
                            ],
                          ),
                        ),
                                                                        
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ):SizedBox(height: size.height * 0.001,),

        ],
      );
      
                
  }
}