import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Malzeme/birim_cevrimi.dart';

class SiparisUrunSecimiDetayRow3 extends StatelessWidget {
  const SiparisUrunSecimiDetayRow3({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SiparisController _controller =Get.find();
    Size size = MediaQuery.of(context).size;
    final Controller mainController =Get.find();
    Locale myLocale = Localizations.localeOf(context);
      final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
        name: "MoneyFormat",symbol: "", decimalDigits: 2);
    
    return Row(
              children: [
                Expanded(flex: 3,child:Column( 
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,                     
                    children: [
                      Padding(padding: EdgeInsets.only(top: 5),
                        child: Text('Birim :', style: TextStyle(fontSize: size.height * ksiparisoran),),
                      ),                        
                    ],
                  ),
                ),

              Expanded(flex: 3,child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonHideUnderline(
                      child: FutureBuilder<List<BirimCevrimi>>(
                      future: _controller.getBirimCevrimi(_controller.secilenUrun.malzemekodu),
                      builder: (BuildContext context, AsyncSnapshot<List<BirimCevrimi>> snapshot) {
                        if (snapshot.hasData) {
                          return DropdownButtonFormField(
                            //style: TextStyle(fontSize: 20),
                            style: TextStyle(fontSize: size.height * ksiparisoran, color: Colors.black),
                            autofocus: false,
                            hint:new Text(_controller.siparisBirimi.value, style: TextStyle(fontSize: size.height * ksiparisoran),),
                            value: _controller.siparisBirimi.value,
                            onChanged: (newValue)async{
                              String siparisBirimi=_controller.siparisBirimi.value;
                              _controller.siparisBirimi.value=newValue;
                              _controller.update();                    

                              if (newValue!="" && newValue!=null && siparisBirimi.toString().trim().toLowerCase()!=newValue.toString().trim().toLowerCase())
                              {
                                double fiyat=await _controller.getbirimBolenBolunen(_controller.secilenUrun.malzemekodu, 
                                  siparisBirimi,newValue, _controller.cfiyat.text, context);

                                String resultfiyat="";
                                if (mainController.birimFiyatRakamSayisi.value>0)
                                {
                                  final bFormat = new NumberFormat.currency(locale: myLocale.languageCode,
                                    name: "",symbol: "", decimalDigits: mainController.birimFiyatRakamSayisi.value);
                                  resultfiyat=bFormat.format(fiyat);
                                }
                                else
                                {
                                  resultfiyat=mFormat.format(fiyat);
                                }
                                _controller.cfiyat.text=resultfiyat;
                                
                                await _controller.tutarHesapla(context);
                              }
                                                  
                            },

                            elevation: 2,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(5),
                              isDense: true
                            ),
                            items: snapshot.data
                              .map<DropdownMenuItem<String>>((BirimCevrimi value) {
                                return DropdownMenuItem<String>(
                                  value: value.birime ,
                                  child: Text(value.birime),
                                );
                              }).toList(),
                            );

                          } else if (snapshot.hasError) {
                            return Text('Error');
                          } else {
                            return Center(child:CircularProgressIndicator(color: Color(0xff009068),),);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 3, child: Column(
                  children: [Text(''),],
                ),
              ),
            ],
          );     

  }
}