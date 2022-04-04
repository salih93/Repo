import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/Screens/Raporlar/AcikHesapListesi/acik_hesap_listesi_toplam.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/rapor_controller.dart';
import 'package:sdrmobil/models/Raporlar/acik_hesap_listesi.dart';

class AcikHesapListesiCard extends StatelessWidget {
  const AcikHesapListesiCard({ Key key, @required this.item, 
              this.index, 
              this.btoplamYaz, 
              this.bSonayaz, 
              this.bbaslikYaz,
              this.grupBazinda,
              this.toplamITutar,
              this.toplamNMiktar,
              this.toplamKdvsiz,
              this.cariKodub,
              this.unvanb,
              this.endtoplamITutar=0,
              this.endtoplamNMiktar=0,
              this.endtoplamKdvsiz=0}) : super(key: key);

  final AcikHesapListesi item;
  final int index;
  final bool btoplamYaz;
  final bool bSonayaz;
  final bool bbaslikYaz;
  final int grupBazinda;

  final double toplamITutar;
  final double toplamNMiktar;
  final double toplamKdvsiz;
  final double endtoplamITutar;
  final double endtoplamNMiktar;
  final double endtoplamKdvsiz;

  final String cariKodub;
  final String unvanb;
  
  
  @override
  Widget build(BuildContext context) {
    final RaporController _controller =Get.find();    
    Locale myLocale = Localizations.localeOf(context);

    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);    
     var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);
     

    initializeDateFormatting(myLocale.languageCode);

    Size size = MediaQuery.of(context).size;    

      return Column(
        children: [
          
          
          btoplamYaz && !bSonayaz ? 
          AcikHesapListesiToplam(toplamITutar: toplamITutar,toplamKdvsiz:toplamKdvsiz ,toplamNMiktar:toplamNMiktar,):SizedBox(height: 0.1,),

          
          ((btoplamYaz && !bSonayaz) || bbaslikYaz) ? Card(
            color: Colors.yellow[600],          
            child:ListTile(            
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
                              Wrap(
                                children: [
                                  Text(cariKodub + ' ',style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                  Text(unvanb, style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                ],
                              ),                                                
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],                  
                ),
            ),            
          ):SizedBox(height: 0.1,),

        
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
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: Wrap(
                                      children: [                                    
                                        Text("İşlem Adı",style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                        Text(": ",style: TextStyle(fontSize: size.height * kAcikHesapOran),),                                 
                                        Text(item.islemTipi,style: TextStyle(fontSize: size.height * kAcikHesapOran, color: Colors.blue[800]),),
                                      ],
                                    ),
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
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: Wrap(
                                      children: [                                    
                                        Text("Fatura No-Tarihi",style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                        Text(": ",style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                        Text(item.faturaNo.toString(),style: TextStyle(fontSize: size.height * kAcikHesapOran, color: Colors.blue[800]),),
                                        Text(" - ",style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                        Text(DateFormat('dd-MM-yyyy').format(item.fisTarihi),style: TextStyle(fontSize: size.height * kAcikHesapOran, color: Colors.blue[800]),),
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
                                Wrap(
                                  children: [
                                    Text("Vade Tarihi",style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                    Text(": ",style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                    Text(DateFormat('dd-MM-yyyy').format(item.vadeTarihi),style: TextStyle(fontSize: size.height * kAcikHesapOran, color: Colors.blue[800]),),                                      
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
                                      Text("Vade Gün Sayısı",style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                      Text(": ",style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                      Text(item.vadeGunSayisi.toString() + ' ',style: TextStyle(fontSize: size.height * kAcikHesapOran, color: Colors.blue[800]),),
                                      Text(item.gecikmeGunu!=0 ? (item.tahsilatGecikti + ' ' + item.gecikmeGunu.toString()):"",
                                        style: TextStyle(fontSize: size.height * kAcikHesapOran, color: Colors.blue[800], fontWeight: FontWeight.bold),),
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
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.cover,
                                  child: Wrap(
                                    children: [
                                      Text("Tutar",style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                      Text(": ",style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                      Text(mFormat.format(item.tefatTutari) + ' ' + format.currencySymbol + ' '+item.borcAlacak +' ',
                                      style: TextStyle(fontSize: size.height * kAcikHesapOran, color: Colors.blue[800]),),
                                    ],
                                  ),
                                ),                                

                              ],
                            ),
                          ),

                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.cover,
                                  child: Wrap(
                                    children: [
                                      Text("Açk Tutar",style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                      Text(": ",style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                      Text(mFormat.format(item.tefatBakiyeTutari)+ ' ' + format.currencySymbol,style: 
                                      TextStyle(fontSize: size.height * kAcikHesapOran, color: Colors.blue[800]),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.cover,
                                  child: Wrap(
                                    children: [
                                      Text("T.Bakiye",style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                      Text(": ",style: TextStyle(fontSize: size.height * kAcikHesapOran),),
                                      Text(mFormat.format(item.bakiyeToplami)+ ' ' + format.currencySymbol,style: 
                                      TextStyle(fontSize: size.height * kAcikHesapOran, color: Colors.blue[800]),),
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
          
          ((btoplamYaz && bSonayaz) || _controller.maxIndex.value==index) ?  
          AcikHesapListesiToplam(toplamITutar: endtoplamITutar,toplamKdvsiz:endtoplamKdvsiz ,toplamNMiktar:endtoplamNMiktar,):SizedBox(height: 0.1,),
         
        ],
      );
      
                
  }
}