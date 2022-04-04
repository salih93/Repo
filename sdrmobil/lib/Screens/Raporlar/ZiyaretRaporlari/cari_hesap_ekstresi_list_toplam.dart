import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';


class CariHesapEkstresiListToplam extends StatelessWidget {
  const CariHesapEkstresiListToplam({
    Key key,  
    this.toplamBorc,
    this.toplamAlacak
  }) : super(key: key);
  final double toplamBorc;
  final double toplamAlacak;
  
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    final noSimbolInUSFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      symbol: "");
      
    Size size = MediaQuery.of(context).size;
    
    return Card(
      color: Colors.green[50],
      child: ListTile( 
      title: Column(
        children: [
          Row(
              children: [
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(                    
                    children: [
                      Text('Toplam Borc',
                        style: TextStyle(fontSize:size.height * ktahsilatoran),
                      ),
                    ],
                  ),

                  Row(children: [
                      Text(noSimbolInUSFormat.format(toplamBorc),
                        style: TextStyle(fontSize:size.height * ktahsilatoran),
                        ),
                      ],
                    ),                                        
                  ],
                ),
              ),
              Expanded(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    children: [
                      Text('Toplam Alacak',
                        style: TextStyle(fontSize:size.height * ktahsilatoran),
                      ),
                    ],
                  ),

                  Row(children: [
                      Text(noSimbolInUSFormat.format(toplamAlacak),
                        style: TextStyle(fontSize:size.height * ktahsilatoran),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    children: [
                      Text('Bakiye',
                        style: TextStyle(fontSize:size.height * ktahsilatoran),
                      ),
                    ],
                  ),

                  Row(children: [
                      (toplamBorc-toplamAlacak)>0 ?
                      Text(noSimbolInUSFormat.format((toplamBorc-toplamAlacak).abs())+' B',
                        style: TextStyle(fontSize:size.height * ktahsilatoran),
                        ):
                      Text(noSimbolInUSFormat.format((toplamBorc-toplamAlacak).abs())+' A',
                        style: TextStyle(fontSize:size.height * ktahsilatoran),
                        ),                     

                      ],
                    ),
                  ],
                ),
              ),
            
            ],
            

          ),               
                
        ]
         
      ),
    ),
   );
  }
}