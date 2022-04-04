import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/models/Malzeme/malzeme_fiyat.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis_gruplu.dart';

class StokFiyatListesiCard extends StatelessWidget {
  const StokFiyatListesiCard({ Key key, @required this.item, this.index, this.bItem}) : super(key: key);
  final MalzemeFiyat item;
  final BekleyenSiparisGruplu bItem;
  final int index;
  
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
    final nFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "",symbol: "", decimalDigits: 0);

    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);
    //final Controller _controller = Get.find();    

    
    initializeDateFormatting(myLocale.languageCode);
    Size size = MediaQuery.of(context).size;    

      return Card(          
           child:ListTile(
            tileColor: (item.rowNum % 2)>0 ? Colors.grey[200]:Colors.white,
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            title: Column(                
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,        
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: size.width * 0.03,),

                          child: Container(                              
                              width: size.width * 0.12,
                              height: size.height * 0.08,
                              child: item.picture!=null ? Image.memory(item.picture):Icon(Icons.error),                              
                            ),                         
                        ),
                  
                        ],
                      ),
                    ),
                  
                    Expanded(
                      flex: 10,
                      child: Column(
                        children: [                        
                          Row(                                  
                            children: [
                              Flexible(
                                child: Text(
                                  item.malzemekodu +' '+item.malzemeadi, 
                                  style: TextStyle(fontSize: size.height * kRaporDetayOran),
                                  maxLines: 4,                                  
                                ),
                              ), 
                            ],
                          ),

                          SizedBox(height:size.height * 0.005),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [                              
                              Expanded(                                
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      alignment: WrapAlignment.start,
                                      crossAxisAlignment: WrapCrossAlignment.start,
                                      children: [
                                      Text('Fiyat     : ',style: TextStyle(fontSize: size.height * kRaporDetayOran),),
                                      Text(mFormat.format(item.birimfiyat)+' '+format.currencySymbol + ' ', style: TextStyle(color: Colors.blue[800], fontSize: size.width * 0.037),),                                      
                                      Text('Bekleyen  : ',style: TextStyle(fontSize: size.height * kRaporDetayOran),),
                                      Text(nFormat.format(bItem.miktar) + ' ' + bItem.bazbirim+ ' ', style: TextStyle(color: Colors.blue[800], fontSize: size.width * 0.037),),                                                                            
                                    ]),
                                  ],
                                ),
                              ),                             
                            ],
                          ),

                                                    
                          
                          SizedBox(height:size.height * 0.005),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [                              
                              Expanded(                                
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      alignment: WrapAlignment.start,
                                      crossAxisAlignment: WrapCrossAlignment.start,
                                      children: [
                                      Text('Stok',style: TextStyle(fontSize: size.height * kRaporDetayOran),),
                                      Text('     : ',style: TextStyle(fontSize: size.width * 0.036),),
                                      Text(nFormat.format(item.stokmiktari)+' ', style: TextStyle(color: Colors.blue[800], fontSize: size.height * kRaporDetayOran),),
                                      Text(item.bazbirim+' ', style: TextStyle(color: Colors.blue[800], fontSize: size.height * kRaporDetayOran),),

                                      Text(item.indirim01flag>0 ? '%' + nFormat.format(item.iskontotutari1):nFormat.format(item.iskontotutari1),
                                        style: TextStyle(fontSize: size.height * kRaporDetayOran),),
                                      Text(item.indirim02flag>0 ? ';%' + nFormat.format(item.iskontotutari2):';'+nFormat.format(item.iskontotutari2),
                                        style: TextStyle(fontSize: size.height * kRaporDetayOran),),
                                      Text(item.indirim03flag>0 ? ';%' + nFormat.format(item.iskontotutari3):';'+nFormat.format(item.iskontotutari3),
                                        style: TextStyle(fontSize: size.height * kRaporDetayOran),),
                                      Text(item.indirim04flag>0 ? ';%' + nFormat.format(item.iskontotutari4):';'+nFormat.format(item.iskontotutari4),
                                        style: TextStyle(fontSize: size.height * kRaporDetayOran),),
                                      Text(item.indirim05flag>0 ? ';%' + nFormat.format(item.iskontotutari5):';'+nFormat.format(item.iskontotutari5),
                                        style: TextStyle(fontSize: size.height * kRaporDetayOran),),
                                      Text(item.indirim06flag>0 ? ';%' + nFormat.format(item.iskontotutari6):';'+nFormat.format(item.iskontotutari6),
                                        style: TextStyle(fontSize: size.height * kRaporDetayOran),),                                      

                                    ]),
                                  ],
                                ),
                              ),                             
                            ],
                          ),

                        ],                      
                      ),
                    ),
                  ],
                
                  
                ),

                  //SizedBox(height: size.height * 0.01,)
                ],
                                
            ),                    
            //trailing: (onTap_!=null) ? Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey,):Text(""),
        ),
      );
                
  }
}