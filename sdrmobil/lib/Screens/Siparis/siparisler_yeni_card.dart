import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/Screens/Siparis/siparis_girisi_urun.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Siparis/siparis.dart';

class YeniSiparislerCard extends StatelessWidget {
  const YeniSiparislerCard({Key key,this.item}) : super(key: key);
  final Siparis item;

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);

    final nFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "",symbol: "", decimalDigits: 0);
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);

    Size size = MediaQuery.of(context).size;

    final SiparisController _controller =Get.find(); 

    
    return Card(
      elevation: 4.0,
      shape: Border(left: BorderSide(color: Color(0xff009068), width: size.width * 0.015)),

      child: InkWell(
          onTap: (){
            if (_controller.siparisslidableCont?.activeState == null)
            {
              if (Slidable.of(context)!=null)  
                Slidable.of(context).open(actionType: SlideActionType.secondary);
            }                
            else
            {
              if (Slidable.of(context)!=null)
                Slidable.of(context).close();
            }

          },
          
        child: Slidable(
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.30,
          controller: _controller.siparisslidableCont,
          key: Key(item.rsayac.toString()),
          
          child: ListTile(
            onTap: () {
              if (_controller.siparisslidableCont?.activeState == null)
              {
                if (Slidable.of(context)!=null)  
                  Slidable.of(context).open(actionType: SlideActionType.secondary);
              }                
              else
              {
                if (Slidable.of(context)!=null)
                  Slidable.of(context).close();
              }
            },

            title: Container(
              width: size.width * 0.90,
              padding: EdgeInsets.only(left:0, right: 0),
              child:Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child:Column(                          
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tip',style: TextStyle(fontSize: size.height * ksiparisoran),),
                          ],                          
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child:Column(                          
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(children: [
                              Text(': '),
                              Text(item.satistipiadi, style: 
                                TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600, fontSize: size.height * ksiparisoran),),
                            ]),                            
                          ],                          
                        ),
                      ),

                      Expanded(
                        flex: 4,
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(FontAwesomeIcons.truck, color: Colors.blue[800],),
                          ],                          
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.0030,),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child:Column(                          
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sipariş No',style: TextStyle(fontSize: size.height * ksiparisoran),),
                          ],                          
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child:Column(                          
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(children: [
                              Text(': '),                               
                              Text(item.siparisno>0 ? item.siparisno.toString():'', 
                                style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600,fontSize: size.height * ksiparisoran),),
                              ],
                            ),                                                        
                          ],                          
                        ),
                      ),

                      Expanded(
                        flex: 4,
                        child:Text(''),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.0030,),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sipariş Tarihi',style: TextStyle(fontSize: size.height * ksiparisoran),),
                          ],                          
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(children: [
                              Text(': '),
                              Text(DateFormat.yMd('tr_TR').format(item.siparistarihi), 
                                style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600,fontSize: size.height * ksiparisoran),),
                              ],
                            ),
                          ],                          
                        ),
                      ),

                      Expanded(
                        flex: 3,
                        child:Text(''),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.0030,),

                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child:Column(                          
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Toplam Miktar',style: TextStyle(fontSize: size.height * ksiparisoran),),
                          ],                          
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(children: [
                              Text(': '),
                              Text(nFormat.format(item.toplammiktar), 
                              style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600, fontSize: size.height * ksiparisoran),),
                            ]),
                          ],                          
                        ),
                      ),                      
                      Expanded(
                        flex: 3,
                        child:Text(''),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.0030,),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Toplam Tutar',style: TextStyle(fontSize: size.height * ksiparisoran),),
                          ],                          
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(children: [
                              Text(': '),
                              Text(mFormat.format(item.toplamtutar) + ' '+format.currencySymbol, 
                              style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600, fontSize: size.height * ksiparisoran),),
                            ],)
                            
                          ],                          
                        ),
                      ),                      
                      Expanded(
                        flex: 3,
                        child:Text(''),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.0030,),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ürün Çeşidi',style: TextStyle(fontSize: size.height * ksiparisoran),),
                          ],                          
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(children: [
                              Text(': '),
                              Text(nFormat.format(item.uruncesidi), 
                                style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600, fontSize: size.height * ksiparisoran),),
                            ],)                            
                          ],                          
                        ),
                      ),                      
                      Expanded(
                        flex: 3,
                        child:Text(''),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.0030,),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Açıklama',style: TextStyle(fontSize: size.height * ksiparisoran),),
                          ],                          
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(children: [
                              Text(': '),
                              Text(item.aciklama, 
                                style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600, fontSize: size.height * ksiparisoran),),
                            ]),
                          ],                          
                        ),
                      ),                      
                      Expanded(
                        flex: 3,
                        child:Text(''),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.0030,),
                ],
              ),

            ),          
          ),

          secondaryActions: [

            Container(
                  alignment: Alignment.center,
                  child: TextButton.icon(                    
                    icon: Icon(Icons.edit_sharp, color: Colors.white,),
                    style: ButtonStyle(
                      alignment: Alignment.topLeft
                    ),

                    label:Text(
                      "Güncelle",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.white, fontSize: size.height * ksiparisoran),
                    ),                    
                    onPressed: () async {
                       await _controller.getSatisTipi();
                      _controller.siparisTipi.value="Satış Siparişi";
                      _controller.satisTipi.value=item.satistipiadi.toString();
                      _controller.satisTipikodu.value=item.satistipi.toString();
                      _controller.siparisTarihiController.text=DateFormat('dd-MM-yyyy').format(item.siparistarihi).toString();
                      _controller.sevkTarihiController.text=DateFormat('dd-MM-yyyy').format(item.sevktarihi).toString();
                      _controller.aciklamaController.text=item.aciklama.toString();
                      _controller.siparisOnay.value=item.onay;

                      _controller.siparissayac.value=item.rsayac; 
                      _controller.sGuid.value=item.guid;                
                      _controller.sepetiac.value=1;
                      _controller.sepetKaydetButton.value=true;

                      _controller.data.clear();
                      _controller.setMalzemeGrup();                                
                      await _controller.malzemeDoldur(0);

                      
                      Navigator.of(context).pop();                
                      Get.to(()=>SiparisGirisiUrun());
                    }
                  ),
                  color: Color(0xff009068),
                ),

            
            Container(
              alignment: Alignment.center,
              color: Colors.red,                  
              child: TextButton.icon(                    
                icon: Icon(Icons.delete, color: Colors.white,),                    
                label:Text(
                  'Sil',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.white, fontSize: size.height * ksiparisoran),
                ),                    
                onPressed: () async {
                  if (item.rsayac>0)
                  {
                    int result=await _controller.deleteSiparis(item.rsayac);                      
                    if (result>0)
                      snackbar("Bilgi", "Sipariş başarıyla silindi.", Icons.thumb_up);
                    _controller.siparissayac.value=1;
                    _controller.siparissayac.value=0;
                  }

                }
              ),
              
            ),

          ],
          
        ),
      ),      
    );

  }
}