import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_uygulanacak.dart';

class UygulanacakKampanyaCard extends StatelessWidget {
  const UygulanacakKampanyaCard({Key key, this.item, this.index}) : super(key: key);
  final KampanyaUygulanacaklar item;
  final int index;

  @override
  Widget build(BuildContext context) {    
    Locale myLocale = Localizations.localeOf(context);
        
    final nFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "",symbol: "", decimalDigits: 0);

    Size size = MediaQuery.of(context).size;

    final SiparisController _controller =Get.find();

    return Card(
      elevation: 2.0,
      //shape: Border(left: BorderSide(color: Color(0xff009068), width: size.width * 0.015)),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 2),
        //minLeadingWidth: 0,        
        title: Row(
          children: [
           Expanded(
             flex: 1,
              child:Checkbox(
                value: (item.secim==1),
                onChanged:(bool value){
                  _controller.changeSecim(item, value);
                },
              ),
            ),

            Expanded(
              flex: 8,
              child:Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child:Wrap(
                                children: [
                                  Text(item.malzemekodu,style: TextStyle(fontSize: size.width * 0.036),),
                                  SizedBox(width: size.width * 0.01,), 
                                  Text(item.malzemeadi,style: TextStyle(color: Colors.blue[800],fontSize: size.width * 0.036),),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,                            
                            children: [
                              FittedBox(
                                fit: BoxFit.contain,
                                child:Wrap(
                                  children: [
                                    Text("Stok",style: TextStyle(fontSize: size.width * 0.036),),
                                    Text(": ",style: TextStyle(fontSize: size.width * 0.036),),
                                    SizedBox(width: size.width * 0.01,), 
                                    Text("0",style: TextStyle(color: Colors.blue[800],fontSize: size.width * 0.036),),
                                  ],
                                ),
                              ),                              
                            ],
                          ),
                        ),
                    ],
                  ),
                  
                  SizedBox(height:size.height * 0.01,),
                  Row(children: [
                      
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child:Wrap(
                                children: [                                  
                                  Text("Kampanya Tipi",style: TextStyle(fontSize: size.width * 0.036),),
                                  Text(": ",style: TextStyle(fontSize: size.width * 0.036),),
                                  Text(item.yuzdeselkampanyaflag>0 ? "Yüzdesel":"Bedelsiz",
                                    style: TextStyle(color: Colors.blue[800],fontSize: size.width * 0.036),),
                                ],                                    
                              ),                                 
                            ),
                          ],
                        ),
                      ),  
                      SizedBox(width: size.width * 0.01,),

                      Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Wrap(
                                  children: [
                                    Text("Grup",style: TextStyle(fontSize: size.width * 0.036),),
                                    Text(": ",style: TextStyle(fontSize: size.width * 0.036),),
                                    SizedBox(width: size.width * 0.01,), 
                                    Text(item.kgrupAdi,style: TextStyle(color: Colors.blue[800],fontSize: size.width * 0.036),),
                                  ],
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                    
                    ],
                  ),
                  
                  SizedBox(height:size.height * 0.01,),                  
                  Row(children: [                      
                      Expanded(                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child:Wrap(
                                children: [
                                  Text("Kampanya Adı",style: TextStyle(fontSize: size.width * 0.036),),
                                  Text(": ",style: TextStyle(fontSize: size.width * 0.036),),
                                  Text(item.kampanyaadi,
                                    style: TextStyle(color: Colors.blue[800],fontSize: size.width * 0.036),),                                
                                ],                                    
                              ),                                 
                            ),
                          ],
                        ),
                      ),  

                    ],
                  ),
                  
                  SizedBox(height:size.height * 0.01,),
                  Row(children: [                      
                      Expanded(                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child:Wrap(
                                children: [
                                  Text("İndirimler",style: TextStyle(fontSize: size.width * 0.036),),
                                  Text(": ",style: TextStyle(fontSize: size.width * 0.036),),
                                  Text(item.kindirimler,
                                    style: TextStyle(color: Colors.blue[800],fontSize: size.width * 0.036),), 
                                ],                                    
                              ),                                 
                            ),
                          ],
                        ),
                      ),  

                    ],
                  ),
                  

                ],
              ),
            ),

            
            item.bedelsizkampanyaflag>0 ? Expanded(
                flex: 1,
                child: Column(
                  children: [
                    DropdownButtonHideUnderline(                                                  
                      child: DropdownButton(                                
                        autofocus: false,
                        hint:new Text(nFormat.format(item.satilacakmiktar),),
                        value: nFormat.format(item.satilacakmiktar),
                        onChanged: (newValue) async {

                          int girilenmiktar=int.parse(_controller.setTutar(newValue.toString(), context));
                          if (!await _controller.miktarOnChange(item, girilenmiktar))
                          {
                            item.satilacakmiktar=0;
                            for (KampanyaUygulanacaklar element in _controller.uygulanacakKampanyalar) {
                              if (element.rowNum==item.rowNum)
                              {                              
                                element.satilacakmiktar=_controller.satilacakmiktar.value;
                                _controller.update();
                                break;                              
                              }                              
                            }
                            return;
                          }

                          item.satilacakmiktar=double.parse(_controller.setTutar(newValue.toString(), context));
                          for (KampanyaUygulanacaklar element in _controller.uygulanacakKampanyalar) {
                            if (element.rowNum==item.rowNum)
                            {
                              _controller.satilacakmiktar.value=0.0;
                              element.satilacakmiktar=item.satilacakmiktar;
                              _controller.satilacakmiktar.value=item.satilacakmiktar;                              
                            }
                            if (element.kampanyaRsayac==item.kampanyaRsayac && element.grupkodu==item.grupkodu)
                            {
                              element.secim=1;
                            }
                          }                                                    
                          _controller.update();
                        },
                        items: _controller.getMiktarDropDownMenuItems(item),
                      ),
                    ),
                            
                  ],

                ),
              ):new Container(),
          ],


        ),

      ),
        
    );

  }
}