import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Siparis/bekleyen_siparis_detay_card.dart';
import 'package:sdrmobil/Screens/Siparis/bekleyen_siparisler_card.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis_grup.dart';

class BekleyenSiparislerW extends StatelessWidget {
  const BekleyenSiparislerW({Key key }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final SiparisController _controller = Get.find();
            
    return CustomScrollView(
      slivers: 
        [    
          SliverFillRemaining(
            child: FutureBuilder<List<BekleyenSiparisGrupAdi>>(              
            future:_controller.bekleyenGrupDoldur(),
            builder: (BuildContext context, AsyncSnapshot<List<BekleyenSiparisGrupAdi>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  semanticChildCount: snapshot.data.length,                      
                  itemBuilder: (context, index) {
                    
                    return DataPopUp(
                    _controller.siparisGrup[index],                    
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

        ],        
      );

  }
}

class DataPopUp extends StatelessWidget {
  const DataPopUp(this.popup, this.size, this.context, this.index);

  final BekleyenSiparisGrup popup;
  final Size size;
  final BuildContext context;
  final int index;

  Widget _buildTiles(
  BekleyenSiparisGrup root, Key key, int index) 
  {   

    if (root.children.isEmpty) 
      return ListTile(title: Text(root.siparisno.toString()));

    return Card(
      child: Align(
        alignment: Alignment(-1.2, 0),        
        child: ExpansionTile(
          tilePadding: EdgeInsets.only(left: 5),
          key: PageStorageKey<BekleyenSiparisGrup>(root),
          //title: Text("Boş"),
          title:BekleyenSiparislerCard(root: root, context: context, index: index,),
          children: detayListBuilderListWidget(root, context, index),
        ),
      ),
    );
  }

   detayListBuilderListWidget(BekleyenSiparisGrup d, BuildContext context, int index) {
    List<Widget> columnContent = [];
    
    d.children.forEach((element) {
      
      columnContent.add(        
        BekleyenSiparisUrunCard(item: element,index: index,),
       );
    });

    return columnContent;
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(popup, key, index);
  }
  
}
