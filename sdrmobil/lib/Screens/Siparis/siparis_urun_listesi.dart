import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Siparis/siparis_urun_listesi_card.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Malzeme/malzeme_fiyat.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis_gruplu.dart';

class SiparisUrunList extends StatelessWidget {
  const SiparisUrunList({Key key }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final SiparisController _controller =Get.find();
        
    return Obx(()=>CustomScrollView(
      slivers: 
        [
          SliverToBoxAdapter(            
            child:Card(
              child: ListTile(
                onTap: (){
                  if (_controller.sepetKaydetButton.value==true)
                      {_controller.sepetKaydetButton.value=false;}
                },                
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      textAlign: TextAlign.center,
                      controller: _controller.searchController,
                      onChanged: (value) {
                        _controller.filterMalzeme(value);
                        _controller.update();
                        _controller.isSearching.value = true;
                      },
                      
                      style: TextStyle(color: Colors.black, backgroundColor: Colors.white, fontSize: size.height * ksiparisoran),                  
                      decoration:InputDecoration(
                        hintText: "Ara...",                        
                        hintStyle: TextStyle(color: Colors.black26, decorationColor: Colors.white),
                        fillColor: Colors.white,
                        focusedBorder: new OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,                            
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(                
                          borderSide: BorderSide(
                            color: Colors.white,                            
                          ),
                        ),


                        suffixIcon:!_controller.isSearching.value ? IconButton(
                          icon: Icon(Icons.search, color: Colors.blue,),
                          iconSize: size.height * kRaporFiltereOran,
                          onPressed:(){
                            _controller.isSearching.value = true;
                            _controller.update();
                          },
                        ):IconButton(
                            onPressed:(){                              
                              _controller.isSearching.value = false;
                              _controller.filteredList = _controller.data;                      
                              _controller.update();
                              _controller.searchController.text="";
                            },                        
                            icon:Icon(Icons.cancel, color: Colors.blue,),
                            iconSize: size.height * kRaporFiltereOran,
                          ),

                        
                      ),

                    ),
                  ],
                ),                  
              ),
            ),
          ),          
   
          SliverFillRemaining(
            child: GetBuilder<SiparisController>(
              builder: (controller) => ListView.builder(
                itemCount: !controller.isSearching.value
                    ? controller.data.length
                    : controller.filteredList.length,
                itemBuilder: (BuildContext context, int index) => DataPopUp(
                    !controller.isSearching.value
                        ? controller.data[index]
                        : controller.filteredList[index],
                    size,
                    context,
                    index),
              ),
            ),
          ),
        ],        
      ),
    );

  }
}

class DataPopUp extends StatelessWidget {
  const DataPopUp(this.popup, this.size, this.context, this.index);

  final YeniListe popup;
  final Size size;
  final BuildContext context;
  final int index;

  Widget _buildTiles(
  YeniListe root, Key key, int index) 
  {
    if (root.children.isEmpty) return ListTile(title: Text(root.grupname, style: TextStyle(fontSize: size.height * ksiparisoran),));
    return Card(
      child: Align(
        alignment: Alignment(-1.2, 0),

        child: ExpansionTile(          
          initiallyExpanded: root.isExpanded,
          key: PageStorageKey<YeniListe>(root),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                root.grupname,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: size.height * ksiparisoran),
              ),            
            ],
          ),

          onExpansionChanged: (value){
            root.isExpanded=value;
          },

          collapsedBackgroundColor: Colors.white,          
          children: detayListBuilderListWidget(root, context, index).toList(),

          /*[
            ExpansionTile(
              // collapsedTextColor: Colors.transparent,              
              title: Text(""),

              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: detayListBuilderListWidget(root, context, index),
              ),
              //children: detayListBuilderListWidget(root, context, index),
              initiallyExpanded: true,
            ),
          ],
          //_detayListBuilderListWidget(root, context, index),
        ),
        */


        ),
      ),
    );

  }

  List<Widget> detayListBuilderListWidget(YeniListe d, BuildContext context, int index) {
    List<Widget> columnContent = [];

    final SiparisController _controller =Get.find();    
    
    d.children.forEach((MalzemeFiyat element) 
    {
      BekleyenSiparisGruplu bitem=new BekleyenSiparisGruplu(malzemekodu: element.malzemekodu,
        miktar: 0, bazbirim: element.bazbirim, birimi: element.bazbirim);

      if (_controller.bekleyenSiparisMalzemeGrup.where((item) => item.malzemekodu==element.malzemekodu).length>0)
        bitem=_controller.bekleyenSiparisMalzemeGrup.firstWhere((item) => item.malzemekodu==element.malzemekodu);

      columnContent.add(
        SiparisUrunListesiCard(item: element,
                            index: index,
                            bItem: bitem,
                            yuzdeselindirim: element.yuzdeselindirim,
                            bedelsizGrupAdi: element.bedelsizGrupAdi,
        ),
      );
    });
    
    return columnContent;
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(popup, key, index);
  }
  
}
