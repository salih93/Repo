import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';


class GunlukSiparisToplamW extends StatelessWidget {
  const GunlukSiparisToplamW({
    Key key,  
    this.toplamMiktar,
    this.toplamTutar,    
  }) : super(key: key);
  final double toplamMiktar;
  final double toplamTutar;

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
    final nFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "",symbol: "", decimalDigits: 0);      
    Size size = MediaQuery.of(context).size;
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);
    
    return Card(
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
                        flex: 3,                      
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                Text("Miktar Toplam" ,style: TextStyle(fontSize: size.height * kgunluksiparisoran, color: Colors.white),),
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
                                Text("Tutar Toplam" ,style: TextStyle(fontSize: size.height * kgunluksiparisoran, color: Colors.white),),
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
                                Text("" ,style: TextStyle(fontSize: size.height * kgunluksiparisoran, color: Colors.white),),
                              ],
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
                            Text(nFormat.format(toplamMiktar), style: TextStyle(fontSize: size.height * kgunluksiparisoran, color: Colors.white),),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mFormat.format(toplamTutar) + ' '+format.currencySymbol,style:TextStyle(fontSize: size.height * kgunluksiparisoran, color: Colors.white),),
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("",style: 
                              TextStyle(fontSize: size.height * kgunluksiparisoran, color: Colors.white),),                      
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