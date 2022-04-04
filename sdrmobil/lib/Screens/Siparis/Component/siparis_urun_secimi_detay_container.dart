import 'package:flutter/material.dart';
import 'package:sdrmobil/Screens/Siparis/Component/siparis_label_textfield.dart';
import 'package:sdrmobil/Screens/Siparis/Component/siparis_label_textfield_focus.dart';
import 'package:sdrmobil/components/label_text_field.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:flutter/services.dart';

class SiparisUrunSecimiDetayContainer extends StatelessWidget {
  const SiparisUrunSecimiDetayContainer({
    Key key,
    @required this.size,
    @required SiparisController controller,
    @required this.anaController,
    @required this.decimal,
  }) : _controller = controller, super(key: key);

  final Size size;
  final SiparisController _controller;
  final Controller anaController;
  final String decimal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.60,              
      child: Card(
        elevation: 0.1,
        child: ListTile(
          contentPadding: EdgeInsets.all(5),
          title: Column(
             
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4,
                      child: Column(                                
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          _controller.picture!=null ? Container(
                            height: size.height * 0.25,
                            width: size.width * 0.35,                                                                        
                            decoration: BoxDecoration(                                    
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:MemoryImage(_controller.picture)
                              ),
                            ),
                          ):Container(
                            height: size.height * 0.10,
                            width: size.width * 0.20,
                            decoration: BoxDecoration(                                    
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/Error.png"),
                              ),
                            ),                                                                        
                          ),

                        ],
                      ),                             
                    ),

                    SizedBox(width: size.width * 0.02,),
                    Expanded(flex: 6,
                      child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Fiyat",style: TextStyle(fontSize: size.height * ksiparisoran),),
                                  ],
                                ),
                              ),

                              Expanded(flex: 3,child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LabelTextField(fontsize: size.height * ksiparisoran, textAlign: TextAlign.end,
                                      labelsize: size.height * ksiparisoran, controller: _controller.cfiyat,                            
                                      inputType: TextInputType.number,readOnly: (anaController.fiyatkilidi.value==1),
                                      inputFormat: [FilteringTextInputFormatter.deny(RegExp('[^0-9$decimal]'), ),],
                                      onTap: (){
                                        _controller.prevCfiyat.value=_controller.cfiyat.text;
                                      },
                                      onChanged: (value)async{                                                
                                        if (!await _controller.tutarHesapla(context))
                                        {
                                          _controller.cfiyat.text=_controller.prevCfiyat.value;
                                        }

                                      },

                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: size.height * 0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Miktar",style: TextStyle(fontSize: size.height * ksiparisoran),),
                                  ],
                                ),
                              ),

                              Expanded(flex: 3,child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LabelTextField(fontsize: size.height * ksiparisoran, textAlign: TextAlign.end,
                                      labelsize: size.height * ksiparisoran, controller: _controller.cmiktar,                            
                                      inputType: TextInputType.number,
                                      readOnly:false, autofocus: true,
                                      inputFormat: [FilteringTextInputFormatter.deny(RegExp('[^0-9$decimal]'), ),],
                                      onTap: (){
                                        _controller.prevCmiktar.value=_controller.cmiktar.text;
                                      },

                                      onChanged: (value) async { 
                                        print("1111111111111");
                                        print(_controller.prevCmiktar.value);

                                        //_controller.cmiktar.text=value.toString();
                                        if (!await _controller.tutarHesapla(context))
                                        {
                                          _controller.cmiktar.text=_controller.prevCmiktar.value;
                                        }
                                      },

                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),

                          SizedBox(height: size.height * 0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Tutar",style: TextStyle(fontSize: size.height * ksiparisoran),),
                                  ],
                                ),
                              ),

                              Expanded(flex: 3,child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SiparisLabelTextField(size: size, controller: _controller.ctutar, decimal: decimal),
                                  ],
                                ),
                              ),

                            ],
                          ),

                          SizedBox(height: size.height * 0.02,),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(flex: 2,
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [                                
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text("Kdvsiz Tutar ",style: TextStyle(fontSize: size.height * ksiparisoran),)),
                                  ],
                                ),
                              ),

                              Expanded(flex: 3,
                                child: Column(                                
                                  children: [                                   
                                    SiparisLabelTextField(size: size, controller: _controller.cindirimlitutar, decimal: decimal),
                                  ],
                                ),
                              ),

                            ],                    
                          ),

                        
                        
                        ],
                      ),
                    ),
                   
                  ],
                ),

                

                SizedBox(height: size.height * 0.002,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 2,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [                                
                          Text("Toplam Tutar:",style: TextStyle(fontSize: size.height * ksiparisoran),),
                        ],
                      ),
                    ),

                    Expanded(flex: 2,
                      child: Column(                                
                        children: [                                   
                          SiparisLabelTextField(size: size, controller: _controller.ctoplamtutar, decimal: decimal),                                    
                        ],
                      ),
                    ),

                  ],                    
                ),

                SizedBox(height: size.height * 0.002,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 2,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [                                
                          Text("Açıklama:",style: TextStyle(fontSize: size.height * ksiparisoran),),
                        ],
                      ),
                    ),

                    Expanded(flex: 2,
                      child: Column(                                
                        children: [ 
                          SiparisLabelTextFieldFocus(size: size, controller: _controller.csatiraciklama, maxLines: 2,),
                        ],
                      ),
                    ),

                  ],                    
                ),


              ],
            ),
          ),
        ),
      );
  }
}
