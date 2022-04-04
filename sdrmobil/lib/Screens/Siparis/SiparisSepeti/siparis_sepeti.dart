import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Siparis/SiparisSepeti/siparis_sepeti_card.dart';
import 'package:sdrmobil/Screens/Siparis/SiparisSepeti/siparis_sepeti_toplam.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir_list.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir_toplam.dart';



class SiparisSepeti extends StatelessWidget {
  const SiparisSepeti({Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final SiparisController _controller =Get.find();
    
    return Obx(()=>CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
              child: SizedBox(          
                  height: size.height * 0.10,
                  child:FutureBuilder<List<SiparisSatirToplam>>(
                    future: _controller.getSiparisToplam(_controller.siparissayac.value),
                    builder: (BuildContext context, AsyncSnapshot<List<SiparisSatirToplam>> snapshot) {
                      if (snapshot.hasData) {
                          SiparisSatirToplam siparisToplam;                  
                                                    
                          siparisToplam=snapshot.data[0];
                          return SiparisSepetiToplamW(tutar: (siparisToplam.tutar==null) ? 0 : siparisToplam.tutar,
                            indirimtutari: (siparisToplam.indirimTutari==null) ? 0: siparisToplam.indirimTutari,
                            kdv: (siparisToplam.kdvTutari==null) ? 0: siparisToplam.kdvTutari,
                            toplamtutar: (siparisToplam.toplamaTutar==null) ? 0:siparisToplam.toplamaTutar,
                          );

                      }else if (snapshot.hasError) {
                        return Text('Error');
                      } else {
                        return Center(child:CircularProgressIndicator(color: Color(0xff009068),),);
                      }
                    },
                  ),
                ),
            ),
            

        
        SliverFillRemaining(
          child: SizedBox(          
            height: size.height * 0.85,
            width: size.width * 0.96,
            child: FutureBuilder<List<SiparisSatirList>>(
              // tahsilatnumber değişince her türlü güncellesin diye.               
              future:_controller.siparissatirrsayac.value>0 ? _controller.getSiparisList(): _controller.getSiparisList(),              
              builder: (BuildContext context, AsyncSnapshot<List<SiparisSatirList>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      SiparisSatirList siparisSatirList;
                      siparisSatirList = snapshot.data[index];
                      return Container(                                                                
                        child: SiparisSepetiCard(item: siparisSatirList, index: index,),
                      );
                    },
                  );                        

                } else if (snapshot.hasError) {
                  return Text('Error');
                } else {
                  //return Text('');
                  return Center(child:CircularProgressIndicator(color: Color(0xff009068),),);
                }
              },                
            ),
          ),
        ),
        
      ],                
      ),
    );
  }
}
