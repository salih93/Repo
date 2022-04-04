import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/models/Raporlar/grup_bazinda_satislar.dart';

class GrupBazindaSatislarCard extends StatelessWidget {
  const GrupBazindaSatislarCard({ Key key, @required this.item, 
              this.index, 
              this.btoplamYaz, 
              this.bSonayaz, 
              this.bbaslikYaz,
              this.grupBazinda,
              this.cariKodub,
              this.unvanb,
              this.toplamIMiktar,
              this.toplamITutar,
              this.toplamNMiktar,
              this.toplamKdvsiz,
              this.toplamSMiktar,
              this.toplamSTutar}) : super(key: key);

  final GrupBazindaSatislarM item;
  final int index;
  final bool btoplamYaz;
  final bool bSonayaz;
  final bool bbaslikYaz;
  final int grupBazinda;

  final double toplamIMiktar;
  final double toplamITutar;
  final double toplamNMiktar;
  final double toplamKdvsiz;
  final double toplamSMiktar;
  final double toplamSTutar;

  final String cariKodub;
  final String unvanb;

  
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

          btoplamYaz && !bSonayaz ? 
          Card(
            color: Colors.teal[800],          
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
                          Wrap(
                            children: [
                              Text(cariKodub + "(Toplam) " ,style: TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.white),),
                            ],
                          ),                                                
                        ],
                      ),
                    ),
                    ],
                  ),
                  
                  SizedBox(height: size.height * 0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(fit: BoxFit.cover,
                                child:Text(nFormat.format(toplamSMiktar) + ' /' + mFormat.format(toplamSTutar)+ ' '+format.currencySymbol,
                                style: TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.white),),                      
                              ),

                              
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(fit: BoxFit.cover,
                                child:Text(nFormat.format(toplamIMiktar)+ '  /' + mFormat.format(toplamITutar) + ' '+format.currencySymbol,style: 
                                TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.white),),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(fit: BoxFit.cover,
                                child:Text(nFormat.format(toplamNMiktar) + ' /'+ mFormat.format(toplamKdvsiz) + ' '+format.currencySymbol,style: 
                                TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.white),),                      
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
                                  Text(item.grupkodu + ' ',style: TextStyle(fontSize: size.height * kGrupBazindaSatislarBasOran1),),
                                  Text(item.grupadi,style: TextStyle(fontSize: size.height * kGrupBazindaSatislarBasOran1),),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.cover,
                                child: Text(item.musterikodu + " / " + item.unvan ,style: TextStyle(fontSize: size.height * kGrupBazindaSatislarBasOran1),),
                              )
                                                    
                            ],
                          ),
                        ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.cover,
                                    child:Text(nFormat.format(item.satisMiktari) + ' '+ item.raporBirimi + '/' + mFormat.format(item.satisKdvOncesiTutar)+ ' '+format.currencySymbol,
                                        style: TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.blue[800]),),                      
                                  ),
                                ],
                              ),
                            ),

                          Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.cover,
                                    child:Text(nFormat.format(item.iadeMiktari)+ ' '+ item.raporBirimi + '/' + mFormat.format(item.iadeKdvOncesiTutar) + ' '+format.currencySymbol,style: 
                                        TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.blue[800]),),                      
                                  ),
                                ],
                              ),
                            ),

                          Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.cover,
                                    child:Text(nFormat.format(item.netMiktar) + ' '+ item.raporBirimi + '/' + mFormat.format(item.netKdvOncesiTutar) + ' '+format.currencySymbol,style: 
                                    TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.blue[800]),),                      
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
          
          (btoplamYaz && bSonayaz) ?  
          Card(
            color: Colors.teal[800],          
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
                          Wrap(
                            children: [
                              Text(cariKodub + "(Toplam) " ,style: TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.white),),
                            ],
                          ),                                                
                        ],
                      ),
                    ),
                    ],
                  ),
                  
                  SizedBox(height: size.height * 0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(fit: BoxFit.cover,
                                child:Text(nFormat.format(toplamSMiktar) + ' /' + mFormat.format(toplamSTutar)+ ' '+format.currencySymbol,
                                style: TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.white),),                      
                              ),

                              
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(fit: BoxFit.cover,
                                child:Text(nFormat.format(toplamIMiktar)+ '  /' + mFormat.format(toplamITutar) + ' '+format.currencySymbol,style: 
                                TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.white),),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(fit: BoxFit.cover,
                                child:Text(nFormat.format(toplamNMiktar) + ' /'+ mFormat.format(toplamKdvsiz) + ' '+format.currencySymbol,style: 
                                TextStyle(fontSize: size.height * kGrupBazindaSatislarOran, color: Colors.white),),                      
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




        ],
      );
      
                
  }
}