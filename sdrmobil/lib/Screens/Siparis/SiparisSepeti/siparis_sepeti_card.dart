import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sdrmobil/Screens/Siparis/SiparisSepeti/siparis_sepeti_card_row1.dart';
import 'package:sdrmobil/Screens/Siparis/SiparisSepeti/siparis_sepeti_card_row2.dart';
import 'package:sdrmobil/Screens/Siparis/SiparisSepeti/siparis_sepeti_card_row3.dart';
import 'package:sdrmobil/Screens/Siparis/siparis_urun_secimi_detay.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir_list.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:sdrmobil/providers/db_provider.dart';

class SiparisSepetiCard extends StatelessWidget {
  const SiparisSepetiCard({ Key key, @required this.item, this.index}) : super(key: key);
  final SiparisSatirList item;
  final int index;
  
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);    
    final SiparisController _controller =Get.find();  
    initializeDateFormatting(myLocale.languageCode);
    Size size = MediaQuery.of(context).size;

      return Card(
          //shape: Border(left: BorderSide(color: Color(0xff009068), width: size.width * 0.015)),
          
          child:InkWell(
            onTap: (){            
              if (_controller.sepetslidableCont?.activeState == null)
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
              actionExtentRatio: 0.25,
              controller: _controller.sepetslidableCont,
              key: Key(item.siparissatirrsayac.toString()),
              enabled: (item.bedelsizkampanyaflag==0) ? true:false,
              
              child: ListTile(
                tileColor: (item.rowNum % 2)>0 ? Colors.grey[200]:Colors.white,

                onTap: () {
                  if (_controller.sepetslidableCont?.activeState == null)
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
                
                contentPadding: EdgeInsets.only(left: size.width * 0.0125, right: 0.0),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,        
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: 
                        [
                          Expanded(
                            flex: 2,
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: size.width * 0.001,),

                                child: Container(                              
                                    width: size.width * 0.12,
                                    height: size.height * 0.08,
                                    child: item.picture!=null ? Image.memory(item.picture):Icon(Icons.error),                              
                                  ),                         
                              ),
                        
                              ],
                            ),
                          ),
                        
                          Expanded(
                            flex: 12,
                            child: Column(
                              children: [                        
                                Row(                                  
                                  children: [
                                    Expanded(child: AutoSizeText(item.malzemeadi , 
                                        style: TextStyle(fontSize: size.height * ksiparisoran5),                                    
                                        overflow: TextOverflow.ellipsis,                                                                            
                                      ),
                                    ),
                                  ],
                                ),

                                
                                SizedBox(height:size.height * 0.005),                         
                                SiparisSepetiCardRow1(item: item),

                                SizedBox(height:size.height * 0.005),
                                SiparisSepetiCardRow2(item: item),

                                SizedBox(height:size.height * 0.005),
                                SiparisSepetiCardRow3(item: item),

                              ],                      
                            ),
                          ),
                        ],
                      ),
                    ],                                  
                  ),                    
                   
              ),
              secondaryActions: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: TextButton.icon(                    
                    icon: Icon(Icons.edit_sharp, color: Colors.white,),                    
                    label:Text(
                      "Güncelle",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.white, fontSize: size.height * ksiparisoran),
                    ),                    
                    onPressed: () async {
                      _controller.getSiparisSatirDegerleriSatirList(item, context);
                      _controller.isSearching.value=true;
                      _controller.isSearching.value=false;
                      await _controller.malzemeDoldur(0);

                      Navigator.of(context).pop();
                      Get.to(()=>SiparisUrunSecimiDetay());
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
                      _controller.siparissayac.value=item.musrsayac;
                      _controller.siparissatirrsayac.value=item.siparissatirrsayac;
                      await DBProvider.db.deleteSiparisSatir(_controller.siparissatirrsayac.value);                                 
                      _controller.siparissatirrsayac.value=0;                    
                      await _controller.malzemeDoldur(0);                      
                      await _controller.getSiparisListCount(0);
                    }
                  ),
                  
                ),
              ],

            ),
          ),
      );
                
  }


}