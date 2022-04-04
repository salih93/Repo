import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:sdrmobil/Screens/Tahsilat/row_input_card.dart';
import 'package:sdrmobil/Screens/Tahsilat/tahsilat_ana_sayfa.dart';
import 'package:sdrmobil/VeritabaniIslemleri/tahsilat_veri_islemleri.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/controller/tahsilat_controller.dart';
import 'package:sdrmobil/models/Tahsilat/kasa_kod_value.dart';


class KrediKartiTahsilatiW extends StatelessWidget {
  KrediKartiTahsilatiW({Key key}):super(key:key);
  final TahsilatController _controller = Get.put(TahsilatController());

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
     items.add(new DropdownMenuItem(
          value: 'K.Kartı Tahsilatı',
          child: new Text('K.Kartı Tahsilatı'),
          ),
        );
    return items;
  }

  @override
  Widget build(BuildContext context) {   
   Size size = MediaQuery.of(context).size;
   var maskFormatter = new MaskTextInputFormatter(mask: '#### #### #### ####', filter: { "#": RegExp(r'[0-9]') });
   
   SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,    
    ]);

    final SiparisController scontroller =Get.find();
    Locale myLocale = Localizations.localeOf(context);    
    var decimal=scontroller.getDecimalSeparator(myLocale.languageCode);
    
    
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff009068),
          title: Text('Tahsilat Girişi', style: TextStyle(color: Colors.white, fontSize: size.height * kRaporOranBaslik),),
          leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
            iconSize: size.height * kRaporFiltereOran,
            onPressed:(){            
              Navigator.of(context).pop();            
              Get.to(()=>TahsilatAnaSayfa());
            },
          ),
          
          actions: [                    
            SizedBox(
              height: size.height * 0.06,
              width: size.width * 0.22,
              child: Padding(
                padding: EdgeInsets.all(size.height * 0.003),
                child: Center(
                  child: TextButton(            
                    style: ButtonStyle(                  
                      backgroundColor: MaterialStateProperty.all(Color(0xff009068)), 
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.white)
                        ),
                      ),
                    ),

                    onPressed: () async {
                        print('Kaydet');                    

                        bool kaydet=await TahsilatVeriIslemleri().krediKartiKaydet();
                        if (kaydet)
                        {
                          _controller.tahsilatnumber.value=1;
                          _controller.tahsilatnumber.value=0;
                          _controller.update();

                          Navigator.of(context).pop();                      
                          Get.to(()=>TahsilatAnaSayfa());
                        }
                    },

                    child: Text("Kaydet", style: TextStyle(color: Colors.white, fontSize: size.height * ktahsilatoran,),
                      ),
                    ),
                ),
              ),
            ),        
          ],

        ),
        

        body: Obx(()=>Background(      
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,              
                children: [
                  Card(child: 
                    ListTile(
                      contentPadding: EdgeInsets.only(left: size.width * ktahsilatoran5),                    
                      title: Row(
                      children: [                    
                        Expanded(flex: 3,child:Column( 
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,                     
                            children: [
                              Padding(padding: EdgeInsets.only(top: 5),
                                child: Text('Fiş Türü :', style:TextStyle(fontSize: size.height * ktahsilatoran5),),
                              ),                        
                            ],
                          ),
                        ),

                        Expanded(flex: 4,child: Column(                        
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButtonHideUnderline(                            
                                child: DropdownButton(   
                                  style: TextStyle(fontSize: size.height * ktahsilatoran5, color: Colors.black),                                                               
                                  autofocus: false,
                                  hint:new Text(_controller.fisturu.value, style: TextStyle(fontSize: size.height * ktahsilatoran5),),
                                  value: _controller.fisturu.value,
                                  onChanged: (newValue){
                                    _controller.fisturu.value=newValue;
                                    _controller.update();                                  
                                  },
                                  items: getDropDownMenuItems().toList(),
                                ),
                              ),
                            ]                      
                          ),
                        ),
                        ],
                      ),
                    ),               
                  ),
                  Card(child: ListTile(
                      contentPadding: EdgeInsets.only(left: size.width * ktahsilatoran5),
                      title: Row(
                        children: [
                          Expanded(flex: 3,child:Column( 
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,                     
                              children: [
                                Padding(padding: EdgeInsets.only(top: 5),
                                  child: Text('Kasa :', style: TextStyle(fontSize: size.height * ktahsilatoran5),),
                                ),                        
                              ],
                            ),
                          ),
                          Expanded(flex: 4,child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButtonHideUnderline(
                                  child: FutureBuilder<List<KasaKodValue>>(
                                  future: _controller.getKasa(1),
                                  builder: (BuildContext context, AsyncSnapshot<List<KasaKodValue>> snapshot) {
                                    if (snapshot.hasData) {
                                      return DropdownButton(
                                        style: TextStyle(fontSize: size.height * ktahsilatoran5, color: Colors.black),
                                        autofocus: false,
                                        hint:new Text(_controller.kasa.value, style: TextStyle(fontSize: size.height * ktahsilatoran5),),
                                        value: _controller.kasa.value,
                                        onChanged: (newValue){
                                          _controller.kasa.value=newValue;
                                          _controller.update();                                  
                                        },
                                        
                                        items: snapshot.data
                                          .map<DropdownMenuItem<String>>((KasaKodValue value) {
                                            return DropdownMenuItem<String>(
                                              value: value.sorumlu ,
                                              child: Text(value.sorumlu),
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

                        ],
                      ),
                    ),
                  ),
                  RowInputCard(
                    controller: _controller.tutarController,
                    hintText: "Tutar Giriniz",
                    inputText: 'Tutar :',                                                             
                    textType: TextInputType.numberWithOptions(decimal: true),
                    inputFormat: [
                      FilteringTextInputFormatter.deny(RegExp('[^0-9$decimal]'),),
                    ],                  
                    //  onTap: ()async{                      
                    //     await showInputKeyboard(_controller.tutarController, context,
                    //       FilteringTextInputFormatter.deny(RegExp('[^0-9,]')), _controller.focusNode
                    //       );
                    //   },
                    //focusNode: _controller.focusNode,
                    autoFocus: true,                  
                    readOnly: false,
                    fontoran: ktahsilatoran5,
                  ),

                  RowInputCard(
                    controller: _controller.makbuzNoController,
                    hintText: "Makbuz no girin",
                    inputText: 'Makbuz No:',
                    onChanged: (value){},                                        
                    autoFocus: true,
                    readOnly: false,
                    fontoran: ktahsilatoran5,
                  ),

                  RowInputCard(
                    controller: _controller.slipNoController,
                    hintText: "Slip no girin",
                    inputText: 'Slip No:',
                    onChanged: (value){},
                    textType: TextInputType.number,
                    autoFocus: true,
                    readOnly: false,
                    fontoran: ktahsilatoran5,
                  ),

                  RowInputCard(
                    controller: _controller.kKartNoController,
                    hintText: "Kart no girin",
                    inputText: 'K.Kartı No:',
                    onChanged: (value){},
                    inputFormat: [maskFormatter],
                    textType: TextInputType.number,
                    autoFocus: true,                  
                    readOnly: false,
                    fontoran: ktahsilatoran5,
                  ),

                  RowInputCard(
                    controller: _controller.aciklamaController,
                    hintText: "Açıklama girin",
                    inputText: 'Açıklama:',
                    onChanged: (value){},
                    textType: TextInputType.multiline,
                    autoFocus: true,
                    readOnly: false,
                    fontoran: ktahsilatoran5,
                  ),

                ],
              ),
            ),      
          ),

      ),
    );    

  }

}