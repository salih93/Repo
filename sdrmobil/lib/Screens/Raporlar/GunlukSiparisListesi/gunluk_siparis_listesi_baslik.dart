
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sdrmobil/constants.dart';


class GunlukSiparisListesiBaslik extends StatelessWidget {
  const GunlukSiparisListesiBaslik({ Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Locale myLocale = Localizations.localeOf(context);
    initializeDateFormatting(myLocale.languageCode);
    Size size = MediaQuery.of(context).size;    

      return Card(          
           child:ListTile(
            //tileColor: (index % 2)>0 ? Colors.grey[200]:Colors.white,
            contentPadding: EdgeInsets.only(left: 5.0, right: 0.0),
            title: 
              Column(                
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
                            Text("Stok Kodu / Adı" ,style: TextStyle(fontSize: size.height * kgunluksiparisoran, fontWeight: FontWeight.bold),),                      
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
                                Text("Miktar",
                                  style: TextStyle(fontSize: size.height * kgunluksiparisoran, fontWeight: FontWeight.bold),),                      
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Toplam Tutar",
                                  style: TextStyle(fontSize: size.height * kgunluksiparisoran, fontWeight: FontWeight.bold),),                      
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Depo",style: 
                                  TextStyle(fontSize: size.height * kgunluksiparisoran, fontWeight: FontWeight.bold),),                      
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