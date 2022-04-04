import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/rapor_controller.dart';

class RaporFiltered extends StatelessWidget {
  const RaporFiltered({Key key, @required this.grupGoster, this.gunlukSiparisR=0}) : super(key: key);
  final int grupGoster;
  final int gunlukSiparisR;

  @override
  Widget build(BuildContext context) {
    final RaporController _controller = Get.put(RaporController());
    Size size = MediaQuery.of(context).size;
    //

    return Obx(()=>Container(
      width: size.width * 0.96,
      child:Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          gunlukSiparisR==0 ? Row(
            children: [
              Expanded(flex: 1,child:Column( 
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,                     
                  children: [
                    Padding(padding: EdgeInsets.only(top: 5),
                      child: Text('Rut: ', style:TextStyle(fontSize: size.height * kRaporDetayOran),),
                    ),                        
                  ],
                ),
              ),

              Expanded(flex: 4,child: Column(                        
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonHideUnderline(                            
                      child: Container(
                        width: size.width * 0.60,                        
                        child: DropdownButton(                          
                          autofocus: false,                        
                          hint:Text(_controller.raporRut.value, style:TextStyle(fontSize: size.height * kRaporDetayOran),),
                          value: _controller.raporRut.value,
                          onChanged: (newValue){
                            _controller.raporRut.value=newValue;
                            _controller.raporMusteriAdi.value="TÜMÜ";                           
                            _controller.update();                                  
                          },
                          items: _controller.getDropDownRutlar().toList(),
                          style: TextStyle(fontSize: size.height * kRaporDetayOran, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 0.5,),

                  ]                      
                ),
              ),
            ],
          ):SizedBox(height: 0.1,),

          gunlukSiparisR==0 ? Row(children: [
               Expanded(flex: 1,child:Column( 
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,                     
                  children: [                    
                    Text('Müşteri:', style: TextStyle(fontSize: size.height * kRaporDetayOran),),                        
                  ],
                ),
              ),

              Expanded(flex: 4,child: Column(                        
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonHideUnderline(                            
                      child: Container(
                        width: size.width * 0.60,
                        child: DropdownButton(
                          isExpanded: true,                                                                                   
                          autofocus: false,
                          hint:new Text(_controller.raporMusteriAdi.value),
                          value: _controller.raporMusteriAdi.value,
                          onChanged: (newValue){
                            _controller.raporMusteriAdi.value=newValue;
                            _controller.update();                                  
                          },
                          items: _controller.getDropDownMusteri().toList(),
                          style: TextStyle(fontSize: size.height * kRaporDetayOran, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 0.5,),

                  ]                      
                ),
              ),
            ],
          ):SizedBox(height: 0.1,),
          
          gunlukSiparisR==1 ? Row(children: [
               Expanded(flex: 1,child:Column( 
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,                     
                  children: [                    
                    Text('Depo: ', style:TextStyle(fontSize: size.height * kRaporDetayOran),),                        
                  ],
                ),
              ),

              Expanded(flex: 4,child: Column(                        
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonHideUnderline(                            
                      child: Container(
                        width: size.width * 0.60,
                        child: DropdownButton(
                          isExpanded: true,                                                                                   
                          autofocus: false,
                          hint:new Text(_controller.raporDepo.value),
                          value: _controller.raporDepo.value,
                          onChanged: (newValue){
                            _controller.raporDepo.value=newValue;
                            _controller.update();                                  
                          },
                          items: _controller.getDropDownDepo().toList(),                          
                          style: TextStyle(fontSize: size.height * kRaporDetayOran, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 0.5,),

                  ]                      
                ),
              ),
            ],
          ):SizedBox(height: 0.1,),
          

          (grupGoster==1 || grupGoster==2) ? Row(children: [
              Expanded(flex: 1,child:Column( 
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,                     
                  children: [
                    Text('Grup 1:', style:TextStyle(fontSize: size.height * kRaporDetayOran),),                        
                  ],
                ),
              ),

              Expanded(flex: 4,child: Column(                        
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonHideUnderline(                            
                      child: Container(
                        width: size.width * 0.60,                        
                        child: DropdownButton(
                          autofocus: false,
                          hint:new Text(_controller.raporMgrup1.value),
                          value: _controller.raporMgrup1.value,
                          onChanged: (newValue){
                            _controller.raporMgrup1.value=newValue;
                            _controller.raporMgrup2.value="TÜMÜ";
                            _controller.raporMgrup3.value="TÜMÜ";
                            _controller.update();                                  
                          },
                          style: TextStyle(fontSize: size.height * kRaporDetayOran, color: Colors.black),
                          items: _controller.getDropDownGrup1().toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 0.5,),

                  ]                      
                ),
              ),
            ],
          ):SizedBox(height: 0.1,),

          (grupGoster==1 || grupGoster==2) ? Row(children: [
              Expanded(flex: 1,child:Column( 
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,                     
                  children: [
                    Text('Grup 2: ', style:TextStyle(fontSize: size.height * kRaporDetayOran),),
                  ],
                ),
              ),
              
              Expanded(flex: 4,child: Column(                        
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonHideUnderline(                            
                      child: Container(
                        width: size.width * 0.60,                        
                        child: DropdownButton(                                
                          autofocus: false,
                          hint:new Text(_controller.raporMgrup2.value),
                          value: _controller.raporMgrup2.value,
                          onChanged: (newValue){
                            _controller.raporMgrup2.value=newValue;
                            _controller.raporMgrup3.value="TÜMÜ";
                            _controller.update();                                  
                          },
                          style: TextStyle(fontSize: size.height * kRaporDetayOran, color: Colors.black),
                          items: _controller.getDropDownGrup2().toList(),
                        ),
                      ),
                    ),                    
                  ]                       
                ),
              ),

            ],
          ):SizedBox(height: 0.1,),

          grupGoster==2 ? Row(children: [
              Expanded(flex: 1,child:Column( 
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,                     
                  children: [
                    Text('Grup 3: ', style:TextStyle(fontSize: size.height * kRaporDetayOran),),
                  ],
                ),
              ),
              
              Expanded(flex: 4,child: Column(                        
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonHideUnderline(                            
                      child: Container(
                        width: size.width * 0.60,                        
                        child: DropdownButton(                                
                          autofocus: false,
                          hint:new Text(_controller.raporMgrup3.value),
                          value: _controller.raporMgrup3.value,
                          onChanged: (newValue){
                            _controller.raporMgrup3.value=newValue;

                            _controller.update();                                  
                          },
                          style: TextStyle(fontSize: size.height * kRaporDetayOran, color: Colors.black),
                          items: _controller.getDropDownGrup3().toList(),
                        ),
                      ),
                    ),                    
                  ]                       
                ),
              ),

            ],
          ):SizedBox(height: 0.1,),

          gunlukSiparisR==0 ? Row(children: [
             Expanded(flex: 1,child:Column( 
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,                     
                  children: [                     
                    Text('Tarih: ',style: TextStyle(fontSize: size.height * kRaporDetayOran)),
                  ],
                ),
              ),

              Expanded(flex: 2,
                child:Column( 
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,                     
                  children: [
                    TextField(
                      controller: _controller.raporTarih1Controller,
                      textInputAction: TextInputAction.done,
                      keyboardType:TextInputType.datetime,
                      readOnly: true,
                      showCursor: true,
                      style: TextStyle(fontSize: size.height * kRaporDetayOran),
                      decoration: InputDecoration(          
                        hintText: "Başlangıç Tarihi",
                        //labelText: "Başlangıç Tarihi",                        
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[400],),                       
                      ),

                      onTap: ()async{
                        await selectDate(context, _controller.raporTarih1Controller, _controller.raporTarih1, 0);
                      },
                    ),
                  ],
                ),                                        
              ),

              Expanded(flex: 2,
                child:Column( 
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,                     
                  children: [
                    TextField(
                      controller: _controller.raporTarih2Controller,
                      textInputAction: TextInputAction.done,
                      keyboardType:TextInputType.datetime,
                      readOnly: true,
                      showCursor: true,
                      style: TextStyle(fontSize: size.height * kRaporDetayOran),
                      decoration: InputDecoration(          
                        hintText: "Bitiş Tarihi",
                        //labelText: "Bitiş Tarihi",                        
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[400] ),                        
                      ),                        
                      onTap: ()async{
                        await selectDate(context, _controller.raporTarih2Controller, _controller.raporTarih2, 1);
                      },
                    ),
                  ],
                ),                                        
              ),
            ],
          ):SizedBox(height: 0.1,),


      ],
    ),
      
    ),
    );

    
  }
  selectDate(BuildContext context, TextEditingController _textEditingController, DateTime tarih, int ikicitarih) async {
    final RaporController _controller = Get.put(RaporController());

    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate:tarih!= null ? tarih : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(DateTime.now().year + 50),  
        locale: Get.locale,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.blue[700],
                surface: Colors.blueAccent[100],
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Colors.blueGrey,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      if (ikicitarih==1)
      {
        if (_controller.raporTarih1==null)
        {          
          snackbar("Uyarı", "Başlangıç tarihi boş olamaz", Icons.person);
          return;
        }

        var berlinWallFell = DateTime(newSelectedDate.year, newSelectedDate.month, newSelectedDate.day);
        var dDay = DateTime(_controller.raporTarih1.year, _controller.raporTarih1.month, _controller.raporTarih1.day);        
        Duration difference = berlinWallFell.difference(dDay);
        if(difference.inDays<0)
        {
          snackbar("Uyarı", "Başlangıç tarihi bitiş tarihinden küçük olamaz!", Icons.person);
          return;
        }

        _controller.raporTarih2=newSelectedDate;
        _controller.update();
      }
      else
      {
        _controller.raporTarih1=newSelectedDate;
        _controller.update();
      }
      
      _textEditingController
        ..text = DateFormat('dd-MM-yyyy').format(newSelectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  
}

