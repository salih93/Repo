import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';
class BekleyenSiparisRaporuBaslik extends StatelessWidget {
  const BekleyenSiparisRaporuBaslik({Key key, this.cariKodub, this.unvanb, this.siparisno, this.siparisasama, this.siparistarihi}) : super(key: key);
  final String siparisno;
  final DateTime siparistarihi;
  final String siparisasama;
  final String cariKodub;
  final String unvanb;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Card(
            color: Colors.yellow[600],          
            child:ListTile(            
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Wrap(
                                children: [
                                  Text('Sip.No: ',style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                  Text(siparisno, style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                  Text(' ',style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                  Text('Sip.Tarihi: ',style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                  Text(DateFormat('dd-MM-yyyy').format(siparistarihi), style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                  Text(' ',style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                  Text('Aşama: ',style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                  Text(siparisasama=="1" ? "Açık":"Kısmi", style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                ],
                              ),                                                
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:size.height * 0.01,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(                      
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Wrap(
                                children: [                                
                                  Text(cariKodub, style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                  Text(' ',style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
                                  Text(unvanb, style: TextStyle(fontSize: size.height * kbekleyensiparisoran),),
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