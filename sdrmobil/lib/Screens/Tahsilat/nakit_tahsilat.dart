import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:sdrmobil/Screens/Tahsilat/row_input_card.dart';
import 'package:sdrmobil/Screens/Tahsilat/tahsilat_ana_sayfa.dart';
import 'package:sdrmobil/VeritabaniIslemleri/tahsilat_veri_islemleri.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/controller/tahsilat_controller.dart';
import 'package:sdrmobil/models/Tahsilat/kasa_kod_value.dart';

SizedBox addPaddingWhenKeyboardAppears() {
  final viewInsets = EdgeInsets.fromWindowPadding(
    WidgetsBinding.instance.window.viewInsets,
    WidgetsBinding.instance.window.devicePixelRatio,
  );

  final bottomOffset = viewInsets.bottom;
  const hiddenKeyboard = 0.0; // Always 0 if keyboard is not opened
  final isNeedPadding = bottomOffset != hiddenKeyboard;

  return SizedBox(height: isNeedPadding ? bottomOffset : hiddenKeyboard);
}

class NakitTahsilatiW extends StatelessWidget {
  NakitTahsilatiW({Key key}):super(key:key);
  final TahsilatController _controller = Get.put(TahsilatController());  


  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
     items.add(new DropdownMenuItem(
          value: 'Nakit Tahsilat',
          child: new Text('Nakit Tahsilat'),
          ),
        );
    return items;
  }

  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;   
  final SiparisController scontroller = Get.find();

   SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,    
    ]);

  Locale myLocale = Localizations.localeOf(context);
  
  var decimal=scontroller.getDecimalSeparator(myLocale.languageCode);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.07),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff009068),
            title: Text('Tahislat Girişi', style: TextStyle(color: Colors.white, fontSize: size.height * kRaporOranBaslik),),
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
                  padding: EdgeInsets.only(bottom:size.height * 0.005, top: size.height * 0.001),
                  child: TextButton(            
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(size.width * 0.18, size.height * 0.01)),                    
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
                        bool kaydet=await TahsilatVeriIslemleri().tahsilatKaydet();
                        if (kaydet)
                        {
                          _controller.tahsilatnumber.value=1;
                          _controller.tahsilatnumber.value=0;
                          _controller.update();
                          Navigator.of(context).pop();
                          //Get.off(TahsilatAnaSayfa());
                          Get.to(()=>TahsilatAnaSayfa());
                        }                    
                    },
                    
                    child: Text("Kaydet", style: TextStyle(color: Colors.white, fontSize: size.height * ktahsilatoran,),
                      ),
                    ),
                ),
              ),        
            ],
          

          ),
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
                                  future: _controller.getKasa(0),
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
                      textType: TextInputType.number,
                      inputFormat: [FilteringTextInputFormatter.deny(RegExp('[^0-9$decimal]'), ),],
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
                    controller: _controller.aciklamaController,
                    hintText: "Açıklama girin",
                    inputText: 'Açıklama:',
                    onChanged: (value){},
                    textType: TextInputType.multiline,                  
                    autoFocus: true,
                    readOnly: false,
                    fontoran: ktahsilatoran5,
                  ),                
                  //addPaddingWhenKeyboardAppears(),

                ],
                
              ),            
            ),
            
          ),
          
      ),
    );

  }





  }

  

