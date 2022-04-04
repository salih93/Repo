import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Siparis/siparis_tum_liste_card.dart';
import 'package:sdrmobil/Screens/Siparis/siparis_tum_liste_detay_card.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';

class SiparisTumListe extends StatelessWidget {
  const SiparisTumListe({ Key key }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final SiparisController _controller =Get.put(SiparisController());
    Size size = MediaQuery.of(context).size;

    return CustomScrollView(
      slivers: [

        SliverFillRemaining(
          child: SizedBox(          
            height: size.height * 0.85,
            width: size.width * 0.96,
            child: FutureBuilder<List<SiparisGrup>>(
              // tahsilatnumber değişince her türlü güncellesin diye.               
              future: _controller.siparisGrupDoldur(),              
              builder: (BuildContext context, AsyncSnapshot<List<SiparisGrup>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      SiparisGrup siparis;
                      siparis = snapshot.data[index];

                    return DataPopUp(
                      siparis,                    
                      size,
                      context,
                      index);
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
    );

  }
}


class DataPopUp extends StatelessWidget {
  const DataPopUp(this.siparis, this.size, this.context, this.index);

  final SiparisGrup siparis;
  final Size size;
  final BuildContext context;
  final int index;

  Widget _buildTiles(SiparisGrup siparis, Key key, int index) 
  {   

    
    return Card(
      shape: Border(left: BorderSide(color: Color(0xff009068), width: size.width * 0.015)),
      child: ExpansionTile(
        tilePadding: EdgeInsets.only(left: 5),
        key: PageStorageKey<String>(siparis.musterino.toString() + siparis.siparistarihi.toString()),
        //title: Text("Boş"),
        title:Container(                                                                
          child: SiparisTumListeCard(item:siparis,),
        ),
        children: detayListBuilderListWidget(siparis, context, index),
      ),
    );


  }

   detayListBuilderListWidget(SiparisGrup d, BuildContext context, int index) {
    List<Widget> columnContent = [];

    d.children.forEach((element) {      
      columnContent.add(        
        SiparisTumListeDetayCard(item: element,index: index,),
       );
    });

    return columnContent;
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(siparis, key, index);
  }
  
}
