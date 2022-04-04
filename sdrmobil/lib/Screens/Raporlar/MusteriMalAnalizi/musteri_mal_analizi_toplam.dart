import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class MusteriMalAnaliziToplamW extends StatelessWidget {
  const MusteriMalAnaliziToplamW({
    Key key,  
    this.toplamSMiktar,
    this.toplamSTutar,
    this.toplamIMiktar,
    this.toplamITutar,
    this.toplamNMiktar,
    this.toplamKdvsiz
  }) : super(key: key);
  final double toplamSMiktar;
  final double toplamSTutar;
  final double toplamIMiktar;
  final double toplamITutar;
  final double toplamNMiktar;
  final double toplamKdvsiz;
  
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
    final nFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "",symbol: "", decimalDigits: 0);
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);
    Size size = MediaQuery.of(context).size;
    
    return Card(
            color: Colors.black,          
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
                                Text("Genel Toplam" ,style: TextStyle(fontSize: size.width * 0.037, color: Colors.white),),
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
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(nFormat.format(toplamSMiktar) + ' /' + mFormat.format(toplamSTutar)+ ' '+format.currencySymbol,
                                style: TextStyle(fontSize: size.width * 0.037, color: Colors.white),),                      
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(nFormat.format(toplamIMiktar)+ '  /' + mFormat.format(toplamITutar) + ' '+format.currencySymbol,style: 
                                TextStyle(fontSize: size.width * 0.037, color: Colors.white),),                      
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(nFormat.format(toplamNMiktar) + ' /'+ mFormat.format(toplamKdvsiz) + ' '+format.currencySymbol,style: 
                                TextStyle(fontSize: size.width * 0.037, color: Colors.white),),                      
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