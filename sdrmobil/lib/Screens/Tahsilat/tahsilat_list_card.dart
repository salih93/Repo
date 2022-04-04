import 'package:flutter/material.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/models/Tahsilat/tahsilat.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TahsilatListCard extends StatelessWidget {
  const TahsilatListCard({ Key key, this.tahsilat}) : super(key: key);  
  final Tahsilat tahsilat; 
  

  @override
  Widget build(BuildContext context) {
        

    Locale myLocale = Localizations.localeOf(context);
    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
          
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);
    initializeDateFormatting(myLocale.languageCode);
    Size size = MediaQuery.of(context).size;

    return InkWell(

      child: Card(      
        elevation: 4.0,
        //kartın yan tarafının rengini değiştiriyor,      
        //shape: Border(left: BorderSide(color: Color(0xff009068), width: size.width * 0.015)),       

        child: ListTile(
          title: Container(
            width: size.width,
            padding: EdgeInsets.only(left:0, right: 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,          
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text('Müşteri', style: TextStyle(fontSize: size.height * ktahsilatoran)),
                              Text('       : ', style: TextStyle(fontSize: size.height * ktahsilatoran5)),
                              Text(tahsilat.unvan, style: TextStyle(color: Colors.blue[800], fontSize: size.height * ktahsilatoran)),
                            ],
                          ),
                        ],
                      ),
                    ),              
                  ],
                ),

                SizedBox(height: size.height * 0.0030,),

                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text('Fiş Türü', style: TextStyle(fontSize: size.height * ktahsilatoran)),
                              Text('      : ', style: TextStyle(fontSize: size.height * ktahsilatoran)),
                              Text(tahsilat.fistur, style: TextStyle(color: Colors.blue[800], fontSize: size.height * ktahsilatoran)),
                              //Text(tahsilat.fistur, style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600),),
                            ],
                          )
                          
                        ],
                      ),
                    ),

                    // Expanded(
                    //   flex: 4,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(tahsilat.unvan, style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600),),
                    //     ],
                    //   ),
                    // ),


                  ],
                ),

                SizedBox(height: size.height * 0.0030,),                
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [                      
                            Wrap(children: [
                              Text('Tarih',style: TextStyle(fontSize: size.height * ktahsilatoran),),
                              Text('            : ', style: TextStyle(fontSize: size.height * ksiparisoran5)),
                              Text(DateFormat.yMd('tr_TR').format(tahsilat.tarih), style: TextStyle(color: Colors.blue[800], fontSize: size.height * ktahsilatoran),),
                            ]),                   
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(children: [
                              Text('Tutar',style: TextStyle(fontSize: size.height * ktahsilatoran),),
                              Text('    : ', style: TextStyle(fontSize: size.height * ktahsilatoran)),
                              Text(mFormat.format(tahsilat.fiyat)+' '+format.currencySymbol, 
                              style: TextStyle(color: Colors.blue[800], 
                                fontSize: mFormat.format(tahsilat.fiyat).length>10 ? (size.height * ktahsilatoran5):(size.height * ktahsilatoran),),),
                            ]),             
                            
                          
                        ],
                      ),
                    ),

                  ],
                ),
                SizedBox(height: size.height * 0.0030,),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          (tahsilat.mutno!=null) ? 
                          Wrap(children: [
                              Text('Makbuz No',style: TextStyle(fontSize: size.height * ktahsilatoran),),
                              Text(': ', style: TextStyle(fontSize: size.height * ktahsilatoran)),
                              Text(tahsilat.mutno.toString(), 
                              style: TextStyle(fontSize: size.height * ktahsilatoran),),
                            ]):Text('Makbuz No : ',style: TextStyle( fontSize: size.height * ktahsilatoran),),

                        ],
                      ),
                    ),
                    
                    Expanded(
                      flex: 4,
                      child: (tahsilat.slipno!=null && tahsilat.slipno!="" ) ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [   
                          Wrap(children: [
                              Text('Slip No',style: TextStyle(fontSize: size.height * ktahsilatoran)),
                              Text('    : ', style: TextStyle(fontSize: size.height * ktahsilatoran)),
                              Text(tahsilat.slipno.toString(), style: TextStyle(fontSize: size.height * ktahsilatoran))
                            ],
                          ),

                           
                        ],
                      ):SizedBox(height: size.height * 0.0000001,),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.0030,),
                (tahsilat.kartno.toString()!="") ? 
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text('K.Kart No', style: TextStyle(fontSize: size.height * ktahsilatoran)),
                              Text('   : ', style: TextStyle(fontSize: size.height * ktahsilatoran)),
                              Text(tahsilat.kartno.toString(), style: TextStyle(fontSize: size.height * ktahsilatoran)),
                            ],
                          ),
                        ],
                      ),
                    ),
      
                  ],
                ):SizedBox(height: size.height * 0.0000001,) ,
                SizedBox(height: size.height * 0.0025,),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text('Açıklama', style: TextStyle(fontSize: size.height * ktahsilatoran)),
                              Text('    : ', style: TextStyle(fontSize: size.height * ktahsilatoran5)),
                              Text(tahsilat.aciklama, style: TextStyle(fontSize: size.height * ktahsilatoran)),
                            ],
                          )                      
                          
                        ],
                      ),
                    ),

              
                  ],
                ),


              ],
            ),
          ),
        ),
        
      ),
    );

  }
}