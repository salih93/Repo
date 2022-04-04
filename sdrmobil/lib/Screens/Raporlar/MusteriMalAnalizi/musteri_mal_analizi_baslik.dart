
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sdrmobil/constants.dart';


class MusteriMalAnaliziBaslik extends StatelessWidget {
  final int grupBazindaSatis;
  const MusteriMalAnaliziBaslik({ Key key, this.grupBazindaSatis=0}) : super(key: key);  
  
  @override
  Widget build(BuildContext context) {

        
    //final Controller _controller = Get.find();    
    Locale myLocale = Localizations.localeOf(context);
    initializeDateFormatting(myLocale.languageCode);
    Size size = MediaQuery.of(context).size;    

      return Card(          
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
                          grupBazindaSatis==1 ? Text("Müşteri Kodu / Ünvanı" ,style: TextStyle(fontSize: size.height * kMusteriMalBasOran, fontWeight: FontWeight.bold),)
                          :Text("Stok Kodu / Adı" ,style: TextStyle(fontSize: size.height * kMusteriMalBasOran, fontWeight: FontWeight.bold),),                      
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
                              FittedBox(fit: BoxFit.cover,
                                child: Text("Satış Mktr/Tutar",
                                style: TextStyle(fontSize: size.height * kMusteriMalBasOran, fontWeight: FontWeight.bold),),
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
                                child:Text("İade Mktr/Tutar",
                                style: TextStyle(fontSize: size.height * kMusteriMalBasOran, fontWeight: FontWeight.bold),),      
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
                                child:Text("N. Mktr/KDVsiz",style: 
                                TextStyle(fontSize: size.height * kMusteriMalBasOran, fontWeight: FontWeight.bold),),
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