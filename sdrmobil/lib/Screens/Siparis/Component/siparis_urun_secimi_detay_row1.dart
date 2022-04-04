
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Siparis/Component/siparis_label_textfield_nofocus.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';

class SiparisUrunSecimiDetayRow1 extends StatelessWidget {
  const SiparisUrunSecimiDetayRow1({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SiparisController _controller =Get.find();
    final Controller anaController = Get.find();
    Size size = MediaQuery.of(context).size;
    
    return  Row(children: [                            
                Expanded(flex: 3,
                  child:Column(
                    children: [
                      SiparisLabelTextFieldNoFocus(size: size,labelText: _controller.secilenUrun.indirim01flag==1 ? "İsk 1(%)":"İsk 1(Tutar)",
                        controller:  _controller.ciskonto1,readOnly: (anaController.iskontokilidi.value==1),
                        onTap: (){
                          _controller.prevCiskonto1.value=_controller.ciskonto1.text;
                        },
                        onChanged: (value) async {
                          if (double.parse(_controller.setTutar(value.toString(), context))>100)
                          {
                            snackbar("Uyarı", "İskonto 1 100 den büyük olamaz!", Icons.person);
                            _controller.ciskonto1.text=_controller.prevCiskonto1.value;                                      
                            return;
                          }
                          if (_controller.iskontoKontrol(value.toString(), 1, context))
                          {                                      
                            if (!await _controller.tutarHesapla(context))
                            {
                              _controller.ciskonto1.text=_controller.prevCiskonto1.value;
                            }
                          }
                          else
                          {
                            _controller.ciskonto1.text=_controller.prevCiskonto1.value;
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
                      SiparisLabelTextFieldNoFocus(size: size,labelText: _controller.secilenUrun.indirim02flag==1 ? "İsk 2(%)":"İsk 2(Tutar)",
                        controller:  _controller.ciskonto2,readOnly: (anaController.iskontokilidi.value==1),
                        onTap: (){
                          _controller.prevCiskonto2.value=_controller.ciskonto2.text;
                        },
                        onChanged: (value) async {
                          if (double.parse(_controller.setTutar(value.toString(), context))>100)
                          {
                            snackbar("Uyarı", "İskonto 2 100 den büyük olamaz!", Icons.person);
                            _controller.ciskonto2.text=_controller.prevCiskonto2.value;
                            return;
                          }
                          if (_controller.iskontoKontrol(value.toString(), 2, context))
                          {                                      
                            if (!await _controller.tutarHesapla(context))
                            {
                              _controller.ciskonto2.text=_controller.prevCiskonto2.value;
                            }
                          }
                          else
                          {
                            _controller.ciskonto2.text=_controller.prevCiskonto2.value;
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
                      SiparisLabelTextFieldNoFocus(size: size,labelText: _controller.secilenUrun.indirim03flag==1 ? "İsk 3(%)":"İsk 3(Tutar)",
                        controller:  _controller.ciskonto3,readOnly: (anaController.iskontokilidi.value==1),                                  
                        onTap: (){
                          _controller.prevCiskonto3.value=_controller.ciskonto3.text;
                        },
                        onChanged: (value) async {
                          if (double.parse(_controller.setTutar(value.toString(), context))>100)
                          {
                            snackbar("Uyarı", "İskonto 3 100 den büyük olamaz!", Icons.person);
                            _controller.ciskonto3.text=_controller.prevCiskonto3.value;
                            return;
                          }
                          if (_controller.iskontoKontrol(value.toString(), 3, context))
                          {                                      
                            if (!await _controller.tutarHesapla(context))
                            {
                              _controller.ciskonto3.text=_controller.prevCiskonto3.value;
                            }
                          }
                          else
                          {
                            _controller.ciskonto3.text=_controller.prevCiskonto3.value;
                          }

                        }

                      ),
                    ],
                  ),
                ),

                //SizedBox(width: size.width * 0.01,),
              ],
            );

              //SizedBox(height: size.height * 0.02,),
  }
}