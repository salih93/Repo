import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Siparis/siparisler_yeni_card.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Siparis/siparis.dart';

class YeniSiparisler extends StatelessWidget {
  const YeniSiparisler({ Key key }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final SiparisController _controller =Get.put(SiparisController());
    Size size = MediaQuery.of(context).size;

    return Obx(()=>CustomScrollView(
      slivers: [

        SliverFillRemaining(
          child: SizedBox(          
            height: size.height * 0.85,
            width: size.width * 0.96,
            child: FutureBuilder<List<Siparis>>(
              // tahsilatnumber değişince her türlü güncellesin diye.               
              future: _controller.siparissayac.value>0 ? _controller.getAllSiparis():_controller.getAllSiparis(),              
              builder: (BuildContext context, AsyncSnapshot<List<Siparis>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Siparis siparis;
                      siparis = snapshot.data[index];
                      return Container(                                                                
                        child: YeniSiparislerCard(item:siparis,),
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
    ),);

  }
}