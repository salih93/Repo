
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir.dart';

class SiparisTumListeDetayCard extends StatelessWidget {
  const SiparisTumListeDetayCard({ Key key, @required this.item, this.index}) : super(key: key);
  final SiparisSatir item;
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

      return Card(
          //shape: Border(left: BorderSide(color: Color(0xff009068), width: size.width * 0.015)),

          child:ListTile(          

           
            contentPadding: EdgeInsets.only(left: size.width * 0.0125, right: 0.0),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,        
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: 
                    [
                      
                      Expanded(
                        flex: 2,
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Padding(
                              padding: EdgeInsets.only(right: size.width * 0.001,),
                              child: item.picture!=null ? Image.memory(item.picture):Icon(Icons.error),
                            )                          
                          ],
                        ),
                      ),
                      

                      SizedBox(width:size.width * 0.005),

                      Expanded(
                        flex: 12,
                        child: Column(
                          children: [                        
                            Row(                                  
                              children: [
                                Expanded(
                                  child: AutoSizeText(item.malzemeadi , 
                                    style: TextStyle(fontSize: size.width * 0.037),                                    
                                    overflow: TextOverflow.ellipsis,                                                                            
                                  ),
                                ),
                              ],
                            ),

                            
                            SizedBox(height:size.height * 0.005),                         
                            Row(
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
                                              Text("Miktar:", style: TextStyle(fontSize: size.width * 0.037),),
                                              ],
                                            ),
                                          ),
                                          
                                          Expanded(flex: 1,          
                                            child:Column(children: [
                                              FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(item.miktar.toStringAsFixed(0), 
                                                    style: TextStyle(color: Colors.blue[800], fontSize: size.width * 0.037),
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
                                        Text("Birim:", style: TextStyle(fontSize: size.width * 0.037),),
                                        Text(item.birimi, 
                                                style: TextStyle(color: Colors.blue[800], fontSize: size.width * 0.037),
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
                                                Text("Fiyat :", style: TextStyle(fontSize: size.width * 0.037),),
                                              ],
                                            ),
                                          ),

                                          Expanded(flex: 1,          
                                            child:Column(children: [
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(mFormat.format(item.birimfiyat)+' '+format.currencySymbol, style: TextStyle(color: Colors.blue[800], fontSize: size.width * 0.037),
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
                            ),

                            SizedBox(height:size.height * 0.005),
                            Row(children: [

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
                                                Text("Tutar:", style: TextStyle(fontSize: size.width * 0.037),),
                                              ],
                                            ),
                                          ),

                                          Expanded(flex: 2,          
                                            child:Column(children: [
                                                FittedBox(
                                                  fit: BoxFit.cover,
                                                  child: Text(mFormat.format(item.tutar)+' '+format.currencySymbol, style: TextStyle(color: Colors.blue[800], fontSize: size.width * 0.037),),
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
                                        Text("Kdv :", style: TextStyle(fontSize: size.width * 0.037),),
                                        Text('%' + mFormat.format(item.kdvorani), style: TextStyle(color: Colors.blue[800], fontSize: size.width * 0.037),),
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
                                      Row(
                                        children: [
                                          Expanded(flex: 2,          
                                            child:Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("T.Tutar:", style: TextStyle(fontSize: size.width * 0.036),),
                                              ],
                                            ),
                                          ),

                                          Expanded(flex: 2,          
                                            child:Column(

                                              children: [
                                                FittedBox(
                                                  fit: BoxFit.contain,
                                                  child:Text(mFormat.format(item.satirtutari) + ' '+format.currencySymbol, style: TextStyle(color: Colors.blue[800], fontSize: size.width * 0.037),),
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
                                          Text('İndirimler: ',style: TextStyle(fontSize: size.width * 0.037),),
                                          Text(item.indirim01flag>0 ? ' %' + nFormat.format(item.indirim01):'0',
                                            style: TextStyle(fontSize: size.width * 0.037),),
                                          Text(item.indirim02flag>0 ? ';%' + nFormat.format(item.indirim02):';0',
                                            style: TextStyle(fontSize: size.width * 0.037),),
                                          Text(item.indirim03flag>0 ? ';%' + nFormat.format(item.indirim03):';0',
                                            style: TextStyle(fontSize: size.width * 0.037),),
                                          Text(item.indirim04flag>0 ? ';%' + nFormat.format(item.indirim04):';0',
                                            style: TextStyle(fontSize: size.width * 0.037),),
                                          Text(item.indirim05flag>0 ? ';%' + nFormat.format(item.indirim05):';0',
                                            style: TextStyle(fontSize: size.width * 0.037),),
                                          Text(item.indirim06flag>0 ? ';%' + nFormat.format(item.indirim06):';0',
                                            style: TextStyle(fontSize: size.width * 0.037),),

                                          Text(" (" + nFormat.format(item.toplamindirim)+' ' + format.currencySymbol + ')', style: TextStyle(color: Colors.blue[800], fontSize: size.width * 0.037),),                           

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
                ],                                  
              ),                    
              
          ),
      );
                
  }
}