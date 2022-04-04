import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';

class SiparisTumListeCard extends StatelessWidget {
  const SiparisTumListeCard({Key key,this.item}) : super(key: key);
  final SiparisGrup item;

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);

    final nFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "",symbol: "", decimalDigits: 0);
    Size size = MediaQuery.of(context).size;
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);
    
    return ListTile(
      contentPadding: EdgeInsets.only(left: 5, right: 0.0),
      title: Container(
        width: size.width * 0.90,
        padding: EdgeInsets.only(left:0, right: 0),
        child:Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Expanded(                    
                  child:Column(                          
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(item.musterino + ' ' + item.unvan,style: TextStyle(fontSize: size.width * 0.036),),
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
                  flex: 3,
                  child:Column(                          
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tip',style: TextStyle(fontSize: size.width * 0.036),),
                    ],                          
                  ),
                ),
                Expanded(
                  flex: 5,
                  child:Column(                          
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(children: [
                        Text(': '),
                        Text(item.satistipiadi, style: 
                          TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600, fontSize: size.width * 0.040),),
                      ]),                            
                    ],                          
                  ),
                ),

                Expanded(
                  flex: 2,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(FontAwesomeIcons.truck, color: Colors.blue[800],),
                    ],                          
                  ),
                ),
              ],
            ),

            SizedBox(height: size.height * 0.0030,),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sipariş Tarihi',style: TextStyle(fontSize: size.width * 0.040),),
                    ],                          
                  ),
                ),
                Expanded(
                  flex: 5,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(children: [
                        Text(': '),
                        Text(DateFormat.yMd('tr_TR').format(item.siparistarihi), 
                          style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600,fontSize: size.width * 0.040),),
                        ],
                      ),
                    ],                          
                  ),
                ),

                Expanded(
                  flex: 2,
                  child:Text(''),
                ),
              ],
            ),

            SizedBox(height: size.height * 0.0030,),

            Row(
              children: [
                Expanded(
                  flex: 3,
                  child:Column(                          
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Toplam Miktar',style: TextStyle(fontSize: size.width * 0.037),),
                    ],                          
                  ),
                ),
                Expanded(
                  flex: 5,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(children: [
                        Text(': '),
                        Text(nFormat.format(item.miktar), 
                        style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600, fontSize: size.width * 0.038),),
                      ]),
                    ],                          
                  ),
                ),                      
                Expanded(
                  flex: 2,
                  child:Text(''),
                ),
              ],
            ),

            SizedBox(height: size.height * 0.0030,),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Toplam Tutar',style: TextStyle(fontSize: size.width * 0.040),),
                    ],                          
                  ),
                ),
                Expanded(
                  flex: 5,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(children: [
                        Text(': '),
                        Text(mFormat.format(item.tutar) + ' '+format.currencySymbol, 
                        style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600, fontSize: size.width * 0.040),),
                      ],)
                      
                    ],                          
                  ),
                ),                      
                Expanded(
                  flex: 2,
                  child:Text(''),
                ),
              ],
            ),

            SizedBox(height: size.height * 0.0030,),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ürün Çeşidi',style: TextStyle(fontSize: size.width * 0.040),),
                    ],                          
                  ),
                ),
                Expanded(
                  flex: 5,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(children: [
                        Text(': '),
                        Text(nFormat.format(item.uruncesidi), 
                          style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600, fontSize: size.width * 0.040),),
                      ],)                            
                    ],                          
                  ),
                ),                      
                Expanded(
                  flex: 2,
                  child:Text(''),
                ),
              ],
            ),

            SizedBox(height: size.height * 0.0030,),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Açıklama',style: TextStyle(fontSize: size.width * 0.040),),
                    ],                          
                  ),
                ),
                Expanded(
                  flex: 5,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(children: [
                        Text(': '),
                        Text(item.aciklama, 
                          style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600, fontSize: size.width * 0.040),),
                      ]),
                    ],                          
                  ),
                ),                      
                Expanded(
                  flex: 2,
                  child:Text(''),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.0030,),
          ],
        ),

      ),          
    );

  }
}