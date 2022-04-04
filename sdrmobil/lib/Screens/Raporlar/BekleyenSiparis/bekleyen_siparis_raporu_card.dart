import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/Screens/Raporlar/BekleyenSiparis/bekleyen_siparis_raporu_baslik.dart';
import 'package:sdrmobil/Screens/Raporlar/BekleyenSiparis/bekleyen_siparis_raporu_toplam.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis.dart';

class BekleyenSiparisRaporuCard extends StatelessWidget {
  const BekleyenSiparisRaporuCard({ Key key, @required this.item, 
              this.index, 
              this.btoplamYaz, 
              this.bSonayaz, 
              this.bbaslikYaz,
              this.grupBazinda,
              this.siparisno,
              this.siparisasama,
              this.siparistarihi,
              this.cariKodub,
              this.unvanb,
              this.toplamSTutar,
              }) : super(key: key);

  final BekleyenSiparis item;
  final int index;
  final bool btoplamYaz;
  final bool bSonayaz;
  final bool bbaslikYaz;
  final int grupBazinda;
  final String siparisno;
  final double toplamSTutar;
  final String cariKodub;
  final String unvanb;
  final DateTime siparistarihi;
  final String siparisasama;


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

          //toplamlar yazılıyor.
          btoplamYaz && !bSonayaz ? 
          BekleyenSiparisRaporuToplam(toplamSTutar: toplamSTutar,):SizedBox(height: 0.1,),

          //başlık yazılıyor.
          ((btoplamYaz && !bSonayaz) || bbaslikYaz) ? 
          BekleyenSiparisRaporuBaslik(cariKodub:cariKodub,unvanb:unvanb,siparisno: siparisno,siparisasama:siparisasama, siparistarihi: siparistarihi,)
          :SizedBox(height: 0.1,),
          
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
                              flex: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Wrap(
                                      children: [                                    
                                        Text("Stok ",style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                        Text(": ",style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),                                 
                                        Text(item.malzemekodu,style: TextStyle(fontSize: size.height * kbekleyensiparisoran, color: Colors.blue[800]),),
                                        Text(" ",style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                        Text(item.malzemeadi,style: TextStyle(fontSize: size.height * kbekleyensiparisoran, color: Colors.blue[800]),),
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
                                      Text("Şube",style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                      Text(": ",style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                      Text(item.subekodu,style: 
                                      TextStyle(fontSize: size.height * kbekleyensiparisoran, color: Colors.blue[800]),),                                  
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
                                Wrap(
                                  children: [
                                    Text("Miktar",style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                    Text(": ",style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                    Text(nFormat.format(item.miktar),style: TextStyle(fontSize: size.height * kbekleyensiparisoran, color: Colors.blue[800]),),                                    
                                  ],
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
                                Wrap(
                                  children: [
                                    Text("Birim",style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                    Text(": ",style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                    Text(item.birimi,style: TextStyle(fontSize: size.height * kbekleyensiparisoran, color: Colors.blue[800]),),
                                  ],
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
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.cover,
                                  child: Wrap(
                                    children: [
                                      Text("Sevk",style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                      Text(": ",style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                      Text(nFormat.format(0),style: TextStyle(fontSize: size.height * kbekleyensiparisoran, color: Colors.blue[800]),),
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
                                  fit: BoxFit.cover,
                                  child: Wrap(
                                    children: [
                                      Text("Kalan",style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                      Text(" : ",style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                      Text(nFormat.format(item.miktar),style: TextStyle(fontSize: size.height * kbekleyensiparisoran, color: Colors.blue[800]),),                                      
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
                                  fit: BoxFit.cover,
                                  child: Wrap(
                                    children: [
                                      Text("S.Tutarı",style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                      Text(": ",style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                      Text(mFormat.format(item.satirtutari) + ' ' + format.currencySymbol,
                                      style: TextStyle(fontSize: size.height * kbekleyensiparisoran, color: Colors.blue[800]),),
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
          
          //toplamlar yazılıyor.
          (btoplamYaz && bSonayaz) ?  
          BekleyenSiparisRaporuToplam(toplamSTutar: toplamSTutar,):SizedBox(height: 0.1,),

         
        ],
      );
      
                
  }
}