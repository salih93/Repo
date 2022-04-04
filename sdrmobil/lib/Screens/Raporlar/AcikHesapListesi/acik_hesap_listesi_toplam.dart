
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';
class AcikHesapListesiToplam extends StatelessWidget {
  const AcikHesapListesiToplam({Key key, this.toplamITutar, this.toplamKdvsiz, this.toplamNMiktar }) : super(key: key);
  final double toplamITutar;
  final double toplamNMiktar;
  final double toplamKdvsiz;

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);    
     var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);

    Size size = MediaQuery.of(context).size;    

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
                  flex: 2,                      
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Tutar Toplam" ,style: TextStyle(fontSize: size.height * kAcikHesapOran, color: Colors.white),),
                    ],
                  ),
                ),

                Expanded(
                  flex: 3,                      
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Açık Tutar Toplam" ,style: TextStyle(fontSize: size.height * kAcikHesapOran, color: Colors.white),),                                   
                    ],
                  ),
                ),

                Expanded(
                  flex: 3,                      
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Toplam Bakiye" ,style: TextStyle(fontSize: size.height * kAcikHesapOran, color: Colors.white),),                                   
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
                  flex: 2,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.cover,
                          child: Wrap(                                  
                            children: [                                    
                              Text(mFormat.format(toplamITutar)+' '+ format.currencySymbol,
                            style: TextStyle(fontSize: size.height * kAcikHesapOran, color: Colors.white),),
                            ]
                          ),
                        ),
                      ],
                    ),
                ),
                
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Wrap(
                          children: [
                                                              
                            Text(mFormat.format(toplamNMiktar)+ ' ' + format.currencySymbol,style: 
                              TextStyle(fontSize: size.height * kAcikHesapOran, color: Colors.white),),
                          ]
                          
                        ),
                      ),
                      
                    ],
                  ),
                ),
                

                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Wrap(
                          children: [
                                                              
                            Text(mFormat.format(toplamKdvsiz) + ' ' + format.currencySymbol,style: 
                              TextStyle(fontSize: size.height * kAcikHesapOran, color: Colors.white),),
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
    );
  }
}