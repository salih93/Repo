import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:sdrmobil/Screens/Siparis/siparis_girisi_urun.dart';
import 'package:sdrmobil/Screens/Siparis/siparisler.dart';
import 'package:sdrmobil/Screens/Tahsilat/row_input_card.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Satis/satis_tipi.dart';

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

class SiparisGirisi extends StatelessWidget {
  SiparisGirisi({Key key}):super(key:key);

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
     items.add(new DropdownMenuItem(
          value: 'Satış Siparişi',
          child: new Text('Satış Siparişi'),
          ),
        );
    return items;
  }

  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;   
   final SiparisController _controller =Get.find();

   SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,    
    ]);

    return Obx(()=>WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,         
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff009068),
          title: Text('Sipariş Girişi', style: TextStyle(color: Colors.white, fontSize: size.height * kRaporOranBaslik),),
          leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
            iconSize: size.height * kRaporFiltereOran,
            onPressed:(){            
              Navigator.of(context).pop();            
              Get.to(()=>Siparisler());
            },
          ),

        ),


        body: Background(      
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,              
                children: [
                  _controller.cariSubeler.length>0 ?
                  Card(child: 
                    ListTile(
                      contentPadding: EdgeInsets.only(left: size.width * ksiparisoran),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [                    
                          Expanded(flex: 3,child:Column( 
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,                     
                              children: [
                                Padding(padding: EdgeInsets.only(top: 5),
                                  child: Text('Şube  :', style:TextStyle(fontSize: size.height * ksiparisoran),),
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
                                    autofocus: false,
                                    
                                    hint:new Text(_controller.subeadi.value, style: TextStyle(fontSize: size.height * ksiparisoran),),
                                    value: _controller.subeadi.value,
                                    onChanged: (newValue){
                                      _controller.subeadi.value=newValue.toString();
                                      _controller.getCariSubeKodu(newValue.toString());
                                      _controller.update();
                                      buttonControl();                                  
                                    },
                                    items: _controller.getCariSubeler(),
                                    style: TextStyle(fontSize: size.height * ksiparisoran, color: Colors.black),
                                  ),
                                ),
                              ]                      
                            ),
                          ),                        
                          SizedBox(height: size.height * 0.005,),
                        ],                      
                      ),
                      
                    ),               
                  ):SizedBox(height: size.height * 0.005,),
                  

                  Card(child: 
                    ListTile( 
                      contentPadding: EdgeInsets.only(left: size.width * ksiparisoran),                   
                      title: Row(
                      children: [                    
                        Expanded(flex: 3,child:Column( 
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,                     
                            children: [
                              Padding(padding: EdgeInsets.only(top: 5),
                                child: Text('Sipariş Tipi :', style:TextStyle(fontSize: size.height * ksiparisoran),),
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
                                  autofocus: false,
                                  hint:new Text(_controller.siparisTipi.value, style: TextStyle(fontSize: size.height * ksiparisoran),),
                                  value: _controller.siparisTipi.value,
                                  onChanged: (newValue){
                                    _controller.siparisTipi.value=newValue;
                                    _controller.update();
                                    buttonControl();                                  
                                  },
                                  items: getDropDownMenuItems().toList(),                                  
                                  style: TextStyle(fontSize: size.height * ksiparisoran, color: Colors.black),
                                ),
                              ),
                            ]                      
                          ),
                        ),
                        
                        ],
                      ),
                    ),
                                   
                  ),                
                  
                  SizedBox(height: size.height * 0.005,),

                  Card(child: ListTile(
                      contentPadding: EdgeInsets.only(left: size.width * ksiparisoran),
                      title: Row(
                        children: [
                          Expanded(flex: 3,child:Column( 
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,                     
                              children: [
                                Padding(padding: EdgeInsets.only(top: 5),
                                  child: Text('Satış Tipi :', style: TextStyle(fontSize: size.height * ksiparisoran),),
                                ),                        
                              ],
                            ),
                          ),
                          Expanded(flex: 4,child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButtonHideUnderline(
                                  child: FutureBuilder<List<SatisTipi>>(
                                  future: _controller.satisTipi.value=="" ? _controller.getSatisTipleri():_controller.getSatisTipleri(),
                                  builder: (BuildContext context, AsyncSnapshot<List<SatisTipi>> snapshot) {
                                    if (snapshot.hasData) {
                                      return DropdownButton(
                                        //style: TextStyle(fontSize: 20),
                                        autofocus: false,
                                        hint:Text(_controller.satisTipi.value, style: TextStyle(fontSize: size.height * ksiparisoran),),
                                        value: _controller.satisTipi.value,
                                        onChanged: (newValue){                                        
                                          _controller.satisTipi.value=newValue;                                        
                                          _controller.update();
                                          buttonControl();
                                          
                                        },
                                        style: TextStyle(fontSize: size.height * ksiparisoran, color: Colors.black),
                                        items: snapshot.data
                                          .map<DropdownMenuItem<String>>((SatisTipi value) {
                                            return DropdownMenuItem<String>(
                                              value: value.satistipi ,
                                              child: Text(value.satistipi, style: TextStyle(fontSize: size.height * ksiparisoran),),
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

                  SizedBox(height: size.height * 0.005,),

                  RowInputCard(
                      controller: _controller.siparisTarihiController,
                      hintText: "Sipariş tarihi girin",
                      inputText: 'Sipariş Tarihi :',                  
                      textType: TextInputType.datetime,                    
                      autoFocus: false,                  
                      readOnly: true,                    
                      onTap: (){
                        buttonControl();
                      },
                      fontoran: ksiparisoran,
                  ),

                  SizedBox(height: size.height * 0.005,),

                  RowInputCard(
                    controller: _controller.sevkTarihiController,
                    hintText: "Sevk tarihi girin",
                    inputText: 'Sevk Tarihi:',                  
                    textType: TextInputType.datetime,                  
                    autoFocus: true,
                    readOnly: true,
                    onTap: () async {
                      await selectDate(context, _controller.sevkTarihiController, _controller.sevkDate, 1);
                      buttonControl();
                    },
                    fontoran: ksiparisoran,                                    
                  ),
                  
                  SizedBox(height: size.height * 0.005,),

                  RowInputCard(
                    controller: _controller.aciklamaController,
                    hintText: "Açıklama girin",
                    inputText: 'Açıklama:',
                    onChanged: (value){},
                    textType: TextInputType.multiline,                  
                    autoFocus: true,
                    readOnly: false,
                    fontoran: ksiparisoran,
                  ),
                  SizedBox(height: size.height * 0.005,),

                  Card(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            SizedBox(
                              width: size.width * 0.60,
                              child: TextButton(                                                              
                                  child: Text(
                                    "DEVAM ET",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: TextButton.styleFrom(                                            
                                    textStyle: TextStyle(fontSize: size.width * 0.045),
                                    backgroundColor: (_controller.isDisable.value) ? Colors.grey:Colors.blue,
                                  ),
                                  onPressed:(_controller.isDisable.value) ? null:() async{
                                    if (_controller.cariSubeler.length>0)
                                    {
                                      if (_controller.subeadi.value=="" || _controller.subeadi.value==null)
                                      { snackbar('Uyarı', "Şube seçmelisiniz!", Icons.error_sharp); return;}
                                    }
                                    if (_controller.siparisTipi.value=="" || _controller.siparisTipi.value==null)
                                      { snackbar('Uyarı', "Sipariş Tipi seçmelisiniz!", Icons.error_sharp); return;}

                                    if (_controller.satisTipi.value=="" || _controller.satisTipi.value==null)
                                      { snackbar('Uyarı', "Satış Tipi seçmelisiniz!", Icons.error_sharp); return;}    

                                    if (_controller.siparisTarihiController.text=="" || _controller.siparisTarihiController.text==null)
                                      { snackbar('Uyarı', "Sipariş tarihi girmelisiniz!", Icons.error_sharp); return;}

                                    if (_controller.sevkTarihiController.text=="" || _controller.sevkTarihiController.text==null)
                                      { snackbar('Uyarı', "Sevk tarihi girmelisiniz!", Icons.error_sharp); return;}


                                    await _controller.setSatisTpiKodu(_controller.satisTipi.value);                                  
                                    _controller.data.clear();

                                    _controller.setMalzemeGrup();                                    
                                    _controller.siparissayac.value=0;
                                    _controller.siparissatirrsayac.value=0;
                                    _controller.sGuid.value="";
                                                                      
                                    await _controller.getSiparisListCount(1);

                                    if (_controller.siparissayac.value>0)
                                    {
                                      await _controller.deleteSiparis(_controller.siparissayac.value);
                                      await _controller.getSiparisListCount(0);
                                      
                                      _controller.siparissayac.value=0; 
                                      _controller.sGuid.value="";                                      
                                     
                                    }
                                    _controller.sepetiac.value=0;
                                    _controller.sepetKaydetButton.value=false;                                 
                                    _controller.siparisOnay.value=0;
                                    _controller.isSearching.value=false;
                                    _controller.searchController.text="";
                                    _controller.sonacilanGrup.value="";
                                    _controller.data.clear();                                    
                                    await _controller.malzemeDoldur(0);
                                    

                                    _controller.update();
                                    Navigator.of(context).pop();                                
                                    Get.to(()=>SiparisGirisiUrun());
                                  },

                                ),
                              ),
                            ],
                          ),
                      ),
                    ),
                ],
                
              ),           
            ),         
        ),
    ),
        
    );

  }

  buttonControl(){

    final SiparisController _controller =Get.find();

    _controller.isDisable.value=true;
    if (_controller.siparisTipi.value!="" && _controller.siparisTipi.value!=null)
      if (_controller.satisTipi.value!="" && _controller.satisTipi.value!=null)    
        if (_controller.siparisTarihiController.text!="" && _controller.siparisTarihiController.text!=null)
          if (_controller.sevkTarihiController.text!="" && _controller.sevkTarihiController.text!=null)          
          {
            if (_controller.cariSubeler.length==0)
              _controller.isDisable.value=false;
            else
            {
              if (_controller.subeadi.value!="" && _controller.subeadi.value!=null)          
                _controller.isDisable.value=false;
            }
          }
    _controller.update();

  }

  selectDate(BuildContext context, TextEditingController _textEditingController, DateTime tarih, int sevkTarihi) async {
    final SiparisController _controller =Get.find();
    Size size = MediaQuery.of(context).size;

    DateTime newSelectedDate = await showDatePicker(   

        context: context,
        initialDate:tarih!= null ? tarih : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(DateTime.now().year + 50),  
        locale: Get.locale,    
        initialDatePickerMode: DatePickerMode.day,
        builder: (context, child) {

          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: size.height * 0.6,
                  width: size.height * 0.8,
                  child: child,
                ),
              ),
            ],
          );

        },      
    );

    if (newSelectedDate != null) {
      if (sevkTarihi==1)
      {
        if (_controller.siparisDate==null)
        {          
          snackbar("Uyarı", "Sipariş tarihi boş olamaz", Icons.person);
          return;
        }

        var berlinWallFell = DateTime(newSelectedDate.year, newSelectedDate.month, newSelectedDate.day);
        var dDay = DateTime(_controller.siparisDate.year, _controller.siparisDate.month, _controller.siparisDate.day);        
        Duration difference = berlinWallFell.difference(dDay);
        if(difference.inDays<0)
        {
          snackbar("Uyarı", "Sevk tarihi sipariş tarihinden küçük olamaz!", Icons.person);
          return;
        }

        _controller.sevkDate=newSelectedDate;
        _controller.update();
      }
      else
      {
        _controller.siparisDate=newSelectedDate;
        _controller.update();
      }
      
      _textEditingController
        ..text = DateFormat('dd-MM-yyyy').format(newSelectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream,
            ));
    }
  }


}

  

