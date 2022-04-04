import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Tahsilat/kredi_karti_tahsilati.dart';
import 'package:sdrmobil/Screens/Tahsilat/nakit_tahsilat.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/tahsilat_controller.dart';
import 'package:sdrmobil/models/Tahsilat/tahsilat.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TahsilatAnaSayfaCard extends StatelessWidget {
  const TahsilatAnaSayfaCard({ Key key, this.tahsilat}) : super(key: key);  
  final Tahsilat tahsilat; 
  

  @override
  Widget build(BuildContext context) {
    final TahsilatController _controller = Get.put(TahsilatController());


    Locale myLocale = Localizations.localeOf(context);
    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);    

    initializeDateFormatting(myLocale.languageCode);
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){    
        if (_controller.tahsilatSlidableCont?.activeState == null)
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

      child: Card(      
        elevation: 4.0,      
        shape: Border(left: BorderSide(color: Color(0xff009068), width: size.width * 0.015)),
        
        child: InkWell(
          onTap: (){
            if (_controller.tahsilatSlidableCont?.activeState == null)
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
            actionPane: SlidableDrawerActionPane(),
            controller: _controller.tahsilatSlidableCont,
            actionExtentRatio: 0.30,
            closeOnScroll: true,
            key: Key(tahsilat.rsayac.toString()),
            child: ListTile(              
              
              title: Container(
                width: size.width,
                padding: EdgeInsets.only(left:0, right: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,          
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tahsilat.fistur, style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.w600, fontSize: size.height * ktahsilatoran),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.0030,),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [                      
                                Wrap(children: [
                                  Text('Tarih               : ',style: TextStyle(fontSize: size.height * ktahsilatoran),),
                                  Text(DateFormat.yMd('tr_TR').format(tahsilat.tarih), style: TextStyle(color: Colors.blue[800], fontSize: size.height * ktahsilatoran),),
                                ]),                   
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(children: [
                                  Text('Tutar   : ',style: TextStyle(fontSize: size.height * ktahsilatoran),),
                                  Text(mFormat.format(tahsilat.fiyat)+' '+format.currencySymbol, 
                                  style: TextStyle(color: Colors.blue[800], 
                                    fontSize: mFormat.format(tahsilat.fiyat).length>10 ? (size.width * 0.0375):(size.height * ktahsilatoran),),),
                                ]),             
                                
                              
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: size.height * 0.0030,),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              (tahsilat.mutno!=null) ? 
                              Wrap(children: [
                                  Text('Makbuz No',style: TextStyle(fontSize: size.height * ktahsilatoran),),
                                  Text('   : ',style: TextStyle(fontSize: size.height * ktahsilatoran0),),
                                  Text(tahsilat.mutno.toString(), 
                                    style: TextStyle(fontSize: size.height * ktahsilatoran),),
                                ]):Text('Makbuz No : ',style: TextStyle( fontSize: size.height * ktahsilatoran),),

                            ],
                          ),
                        ),
                        
                        Expanded(
                          flex: 4,
                          child: (tahsilat.slipno!=null && tahsilat.slipno!="" ) ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [                      
                               Text('Slip No: ' + tahsilat.slipno.toString(), 
                                style: TextStyle(fontSize: size.height * ktahsilatoran))
                            ],
                          ):SizedBox(height: size.height * 0.0000001,),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.0030,),
                    (tahsilat.kartno.toString()!="") ? 
                    Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  Text('K.Kart No', style: TextStyle(fontSize: size.height * ktahsilatoran)),
                                  Text('       : ', style: TextStyle(fontSize: size.height * ktahsilatoran3)),
                                  Text(tahsilat.kartno.toString(), style: TextStyle(fontSize: size.height * ktahsilatoran)),
                                ],
                              ),
                            ],
                          ),
                        ),
      
                      ],
                    ):SizedBox(height: size.height * 0.0000001,) ,
                    SizedBox(height: size.height * 0.0025,),
                    Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  Text('Açıklama', style: TextStyle(fontSize: size.height * ktahsilatoran)),
                                  Text('       : ', style: TextStyle(fontSize: size.height * ktahsilatoran)),
                                  Text(tahsilat.aciklama, style: TextStyle(fontSize: size.height * ktahsilatoran)),
                                ],
                              )                      
                              
                            ],
                          ),
                        ),

                  
                      ],
                    ),


                  ],
                ),
              ),
            ),
            secondaryActions: <Widget>[ 

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
                          fontWeight: FontWeight.normal, color: Colors.white, fontSize: size.height * ktahsilatoran5),
                    ),                    
                    onPressed: () async {
                      if (tahsilat.rsayac>0)
                      {
                        if (tahsilat.fistur=="Nakit Tahsilat")
                        {
                          _controller.tahsilatsayac.value=0;
                          _controller.fisturu.value=tahsilat.fistur;
                          _controller.kasa.value=tahsilat.kasa.toString();
                          _controller.tutarController.text=tahsilat.fiyat.toString().replaceAll('.', ',');
                          _controller.makbuzNoController.text=tahsilat.mutno;
                          _controller.slipNoController.text="";
                          _controller.kKartNoController.text="";
                          _controller.aciklamaController.text=tahsilat.aciklama;
                          _controller.tahsilatsayac.value=tahsilat.rsayac;
                          _controller.update();

                          Get.to(()=>NakitTahsilatiW());
                        }
                        if (tahsilat.fistur=="K.Kartı Tahsilatı")
                        {
                          _controller.tahsilatsayac.value=0;
                          _controller.fisturu.value=tahsilat.fistur;
                          _controller.kasa.value=tahsilat.kasa.toString();
                          _controller.tutarController.text=tahsilat.fiyat.toString().replaceAll('.', ',');
                          _controller.makbuzNoController.text=tahsilat.mutno;
                          _controller.slipNoController.text=tahsilat.slipno;
                          _controller.kKartNoController.text=tahsilat.kartno;
                          _controller.aciklamaController.text=tahsilat.aciklama;
                          _controller.tahsilatsayac.value=tahsilat.rsayac;
                          _controller.update();
                          Get.to(()=>KrediKartiTahsilatiW());
                        }                       
                        
                      }  

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
                          fontWeight: FontWeight.normal, color: Colors.white, fontSize: size.height * ktahsilatoran5),
                    ),                    
                    onPressed: () async {
                      if (tahsilat.rsayac>0)
                        {
                          String result=await _controller.deleteTahsilat(tahsilat.rsayac);                      
                          snackbar("Bilgi", result, Icons.thumb_up);                    
                          _controller.tahsilatnumber.value=tahsilat.rsayac;
                        }                
                    }
                  ),                  
                ),

           
              
              ],

          ),
        ),
        
      ),
    );

  }
}