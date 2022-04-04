
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Siparis/Component/siparis_label_textfield_nofocus.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';

class SiparisUrunSecimiDetayRow2 extends StatelessWidget {
  const SiparisUrunSecimiDetayRow2({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SiparisController _controller =Get.find();
    final Controller anaController = Get.find();
    Size size = MediaQuery.of(context).size;
    
    return Row(
            children: [
              Expanded(flex: 3,
                child:Column(
                  children: [
                    SiparisLabelTextFieldNoFocus(size: size,labelText: _controller.secilenUrun.indirim04flag==1 ? "İsk 4(%)":"İsk 4(Tutar)",
                      controller:  _controller.ciskonto4,readOnly: (anaController.iskontokilidi.value==1),
                      onTap: (){
                        _controller.prevCiskonto4.value=_controller.ciskonto4.text;
                      },
                      onChanged: (value) async {
                        if (double.parse(_controller.setTutar(value.toString(), context))>100)
                        {
                          snackbar("Uyarı", "İskonto 4 100 den büyük olamaz!", Icons.person);
                          _controller.ciskonto4.text=_controller.prevCiskonto4.value;
                          return;
                        }
                        if (_controller.iskontoKontrol(value.toString(), 4, context))
                        {                                      
                          if (!await _controller.tutarHesapla(context))
                          {
                            _controller.ciskonto4.text=_controller.prevCiskonto4.value;
                          }
                        }
                        else
                        {
                          _controller.ciskonto4.text=_controller.prevCiskonto4.value;
                        }

                      }
                    ),
                  ],
                ),
              ),

              SizedBox(width: size.width * 0.01,),
              Expanded(flex: 3,
                child:Column(
                  children: [
                    SiparisLabelTextFieldNoFocus(size: size,labelText: _controller.secilenUrun.indirim05flag==1 ? "İsk 5(%)":"İsk 5(Tutar)",
                      controller:  _controller.ciskonto5,readOnly: (anaController.iskontokilidi.value==1),
                      onTap: (){
                        _controller.prevCiskonto5.value=_controller.ciskonto5.text;
                      },
                      onChanged: (value) async {
                        if (double.parse(_controller.setTutar(value.toString(), context))>100)
                        {
                          snackbar("Uyarı", "İskonto 5 100 den büyük olamaz!", Icons.person);
                          _controller.ciskonto5.text=_controller.prevCiskonto5.value;
                          return;
                        }
                        if (_controller.iskontoKontrol(value.toString(), 5, context))
                        {                                      
                          if (!await _controller.tutarHesapla(context))
                          {
                            _controller.ciskonto5.text=_controller.prevCiskonto5.value;
                          }
                        }
                        else
                        {
                          _controller.ciskonto5.text=_controller.prevCiskonto5.value;
                        }


                      }
                    ),
                  ],
                ),
              ),

              SizedBox(width: size.width * 0.01,),
              Expanded(flex: 3,
                child:Column(
                  children: [
                    SiparisLabelTextFieldNoFocus(size: size,labelText: _controller.secilenUrun.indirim06flag==1 ? "İsk 5(%)":"İsk 5(Tutar)",
                      controller:  _controller.ciskonto6,readOnly: (anaController.iskontokilidi.value==1),
                      onTap: (){
                        _controller.prevCiskonto6.value=_controller.ciskonto6.text;
                      },
                      onChanged: (value)async{                                    
                        if (double.parse(_controller.setTutar(value.toString(), context))>100)
                        {
                          snackbar("Uyarı", "İskonto 6 100 den büyük olamaz!", Icons.person);
                          value=_controller.ciskonto6.text;
                          return;
                        }                                    
                        if (_controller.iskontoKontrol(value.toString(), 6, context))
                        {                                      
                          if (!await _controller.tutarHesapla(context))
                          {
                            _controller.ciskonto6.text=_controller.prevCiskonto6.value;
                          }
                        }
                        else
                        {
                          _controller.ciskonto6.text=_controller.prevCiskonto6.value;
                        }
                        
                      },

                    ),
                  ],
                ),
              ),
            ],
          );  //SizedBox(height: size.height * 0.02,),
  }
}