
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/Screens/Siparis/siparis_urun_secimi_detay.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Malzeme/malzeme_fiyat.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis_gruplu.dart';

class SiparisUrunListesiCard extends StatelessWidget {
  const SiparisUrunListesiCard({ Key key, 
                @required this.item, 
                this.onTap_, 
                this.index, 
                this.bItem,
                this.yuzdeselindirim,                
                this.bedelsizGrupAdi,
                this.grupadi}) : super(key: key);

  final MalzemeFiyat item;
  final BekleyenSiparisGruplu bItem;
  final Function onTap_;
  final int index;
  final double yuzdeselindirim;    
  final String bedelsizGrupAdi;
  final String grupadi;
  
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
      
    final nFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "",symbol: "", decimalDigits: 0);
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);

    final SiparisController _controller =Get.find();    
    
    initializeDateFormatting(myLocale.languageCode);
    Size size = MediaQuery.of(context).size;

      return Card(          
            child:
              ListTile(
                dense:true,
                tileColor: (item.rowNum % 2)>0 ? Colors.yellow[50]:Colors.white,            
                trailing:Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  item.siparissatirrsayac>0 && item.ciftkayit==1 ?
                  IconButton(onPressed: (){},icon:
                  Icon(FlutterIcons.check_double_faw5s, color: Colors.blue, size: size.width * 0.04,),):
                  SizedBox(height: size.height * 0.001,),

                  (item.siparissatirrsayac==0 || item.siparissatirrsayac==null || item.ciftkayit==1) ? 
                    IconButton(onPressed: (){
                    final Controller mainController =Get.find();

                    _controller.secilenUrun=item;
                    _controller.setIskonto(item.iskontotutari1.toString(), 1,context);
                    _controller.setIskonto(item.iskontotutari2.toString(), 2,context);
                    _controller.setIskonto(item.iskontotutari3.toString(), 3,context);
                    _controller.setIskonto(item.iskontotutari4.toString(), 4,context);
                    _controller.setIskonto(item.iskontotutari5.toString(), 5,context);
                    _controller.setIskonto(item.iskontotutari6.toString(), 6,context);

                    //formatlancak.
                    String resultfiyat=item.birimfiyat.toString();
                    if (mainController.birimFiyatRakamSayisi.value>0)
                    {
                      final bFormat = new NumberFormat.currency(locale: myLocale.languageCode,
                        name: "",symbol: "", decimalDigits: mainController.birimFiyatRakamSayisi.value);
                      resultfiyat=bFormat.format(item.birimfiyat);
                    }
                    else
                    {
                      resultfiyat=mFormat.format(item.birimfiyat);
                    }

                    _controller.cfiyat.text=resultfiyat;
                    _controller.cbirim.text=item.bazbirim;
                    _controller.siparisBirimi.value=item.bazbirim;
                    _controller.cmiktar.text="";
                    _controller.ctutar.text="0";
                    _controller.cindirimlitutar.text="0";
                    _controller.ctoplamtutar.text="0";
                    _controller.picture=null;
                    _controller.picture=item.picture==null ? null:item.picture;

                    _controller.tutar.value=0;
                    _controller.kdvTutari.value=0;
                    _controller.indirimTutari.value=0;
                    _controller.toplamaTutar.value=0;
                    _controller.sGuid.value="";
                    _controller.bedelsizptr.value="";
                    _controller.siparissatirrsayac.value=0;
                    _controller.sonacilanGrup.value=grupadi;
                    _controller.update();
                    Navigator.of(context).pop();
                    Get.to(()=>SiparisUrunSecimiDetay());
                  },
                  icon:Icon(Icons.add, color: Colors.black, size: size.width * 0.075,),
                  ): item.ciftkayit==0 ? 
                  IconButton(onPressed: (){},icon:
                  Icon(FlutterIcons.check_double_faw5s, color: Colors.blue, size: size.width * 0.04,),):
                  SizedBox(height: size.height * 0.001,),

                  ],
                ),

            onTap: onTap_,            
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            title: Column(                
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,        
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.03,),
                        child: Container(                              
                            width: size.width * 0.12,
                            height: size.height * 0.08,
                            
                            child: item.picture!=null ? Image.memory(item.picture):Icon(Icons.error), 
                            //child: Icon(Icons.error),                             
                          ),                         
                      ),
                
                      ],
                    ),                      
                  ),
                
                  Expanded(
                    flex: 10,
                    child: Column(
                      children: [                        
                        Row(                                  
                          children: [
                            Flexible(
                              child: Text(
                                item.malzemekodu +' '+item.malzemeadi, 
                                style: TextStyle(fontSize: size.height * ksiparisoran3),
                                maxLines: 4,
                                //overflow: TextOverflow.fade,                                    
                                //textAlign: TextAlign.justify,
                              ),
                            ), 
                          ],
                        ),

                        SizedBox(height:size.height * 0.005),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [                              
                            Expanded(
                              flex: 5,                                
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    children: [
                                    Text('Fiyat     : ',style: TextStyle(fontSize: size.height * ksiparisoran3),),
                                    Text(mFormat.format(item.birimfiyat)+' '+format.currencySymbol + ' ', style: TextStyle(color: Colors.blue[800], fontSize: size.height * ksiparisoran3),),                                      
                                    Text('Bekleyen  : ',style: TextStyle(fontSize: size.height * ksiparisoran3),),
                                    Text(nFormat.format(bItem.miktar) + ' ' + bItem.bazbirim+ ' ', style: TextStyle(color: Colors.blue[800], fontSize: size.height * ksiparisoran3),),                                      
                                  ]),
                                ],
                              ),
                            ),
                            

                          ],
                        ),

                        SizedBox(height:size.height * 0.005),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [                              
                            Expanded(
                              flex: 5,                                
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    children: [
                                      Text('Barkod : ',style: TextStyle(fontSize: size.height * ksiparisoran3),),
                                      Text(item.barkod.toString().trim(), style: TextStyle(color: Colors.blue[800], fontSize: size.height * ksiparisoran3),),
                                  ]),
                                ],
                              ),
                            ),                             
                            
                          ],

                        ),
                        
                        SizedBox(height:size.height * 0.005),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [                              
                            Expanded(                                
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    children: [
                                    Text('Stok',style: TextStyle(fontSize: size.height * ksiparisoran3),),
                                    Text('      : ',style: TextStyle(fontSize: size.width * 0.035),),
                                    Text(nFormat.format(item.stokmiktari)+' ', style: TextStyle(color: Colors.blue[800], fontSize: size.height * ksiparisoran3),),
                                    Text(item.bazbirim+' ', style: TextStyle(color: Colors.blue[800], fontSize: size.height * ksiparisoran3),),

                                    Text(item.indirim01flag>0 ? '%' + nFormat.format(item.iskontotutari1):nFormat.format(item.iskontotutari1),
                                      style: TextStyle(fontSize: size.height * ksiparisoran3),),
                                    Text(item.indirim02flag>0 ? ';%' + nFormat.format(item.iskontotutari2):';'+nFormat.format(item.iskontotutari2),
                                      style: TextStyle(fontSize: size.height * ksiparisoran3),),
                                    Text(item.indirim03flag>0 ? ';%' + nFormat.format(item.iskontotutari3):';'+nFormat.format(item.iskontotutari3),
                                      style: TextStyle(fontSize: size.height * ksiparisoran3),),
                                    Text(item.indirim04flag>0 ? ';%' + nFormat.format(item.iskontotutari4):';'+nFormat.format(item.iskontotutari4),
                                      style: TextStyle(fontSize: size.height * ksiparisoran3),),
                                    Text(item.indirim05flag>0 ? ';%' + nFormat.format(item.iskontotutari5):';'+nFormat.format(item.iskontotutari5),
                                      style: TextStyle(fontSize: size.height * ksiparisoran3),),
                                    Text(item.indirim06flag>0 ? ';%' + nFormat.format(item.iskontotutari6):';'+nFormat.format(item.iskontotutari6),
                                      style: TextStyle(fontSize: size.height * ksiparisoran3),),                                      

                                  ]),
                                ],
                              ),
                            ),                             
                          ],
                        ),
                        SizedBox(height:size.height * 0.005),
                      ],                      
                    ),
                  ),
                  
                  
                ],
              
                
              ),

              SizedBox(height:size.height * 0.005),

              

            ],
                              
          ),

            subtitle:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Expanded(
                        //flex: 5,
                        flex: 2,
                        child: 
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(""),                  
                          ],
                        ),
                      ),

                      yuzdeselindirim>0 ? Expanded(
                        //flex: 10,
                        flex: 3,                              
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Wrap(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      color: Colors.blue,
                                    ),

                                    child: Text("YDS",
                                      style: TextStyle(
                                        backgroundColor: Colors.blue,
                                        fontSize: size.height * ksiparisoran3, color: Colors.white
                                      ),
                                    ),
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                    ),

                                    child: Text(' %' + mFormat.format(yuzdeselindirim),
                                      style: TextStyle(                                            
                                        backgroundColor: (item.rowNum % 2)>0 ? Colors.yellow[50]:Colors.white,
                                        fontSize: size.height * ksiparisoran3, color: Colors.black
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),                                   
                          ],
                        ),
                      ):Expanded(
                        flex: 3,
                        child: 
                        Column(
                          children: [
                          ],
                        ),
                      ),
                      
                      SizedBox(width:size.width * 0.005),

                      bedelsizGrupAdi!="" ? Expanded(                              
                        //flex: 17,
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Wrap(
                                children: [
                                  Container(                                
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xff009068)),
                                      color: Color(0xff009068),
                                    ),

                                    child: Text("BDZ",
                                      style: TextStyle(
                                        backgroundColor: Color(0xff009068),
                                        fontSize: size.height * ksiparisoran3, color: Colors.white
                                      ),
                                    ),
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xff009068)),
                                    ),
                                    child: Text(' ' + bedelsizGrupAdi,
                                      style: TextStyle(  
                                        decorationColor: Colors.black,                                            
                                        backgroundColor: (item.rowNum % 2)>0 ? Colors.yellow[50]:Colors.white,
                                        fontSize: size.height * ksiparisoran3, color: Colors.black
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ):Expanded(
                        flex: 7,
                        child: 
                        Column(
                          children: [
                          ],
                        ),
                      ),

                    ],
                  ),

            //trailing: (onTap_!=null) ? Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey,):Text(""),
        ),
      );
      
                
  }
}