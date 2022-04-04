import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Raporlar/ZiyaretRaporlari/cari_satislar.dart';
import 'package:sdrmobil/Screens/Raporlar/ZiyaretRaporlari/cari_satislar_aylik_card.dart';
import 'package:sdrmobil/Screens/Raporlar/ZiyaretRaporlari/cari_satislar_card.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/models/Satis/aylik_satis.dart';

class CariSatislarAylikW extends StatelessWidget {
  const CariSatislarAylikW({ Key key, @required this.ekstre}) : super(key: key);
  final CariAylikSatis ekstre;  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;    
    final Controller _controller = Get.find(); 
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,    
    ]);

        
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff009068),          
          title: Text('Aylık Satışlar', style: TextStyle(fontSize: size.height * kRaporOranBaslik)),          
          actions: [
            Row(              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Padding(padding:EdgeInsets.only(right: 10) ,child: Image.asset(
                    'assets/images/sdr-upbar-logo-icon.png',
                    fit: BoxFit.contain,
                    height: 40,
                  ),
                ),
              ],
            ),
          ],
           leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
           iconSize: size.height * kRaporFiltereOran,
            onPressed:(){            
              Navigator.of(context).pop();            
              Get.to(()=>CariSatislarW());
            },
          ),

        ),
            
        body: CustomScrollView(
          slivers: [

            SliverToBoxAdapter(
              child: SizedBox(
                height: size.height * 0.17,
                child: Column(
                  children:[                    
                    
                    Container(
                      height: size.height * 0.1,
                      child: CariSatislarCard(ekstre: ekstre)
                    ),

                    Divider(
                      color: Colors.white,
                      height: 0.01,
                    ),
                    Container(
                      height: size.height * 0.06,
                      child: Card(
                        child:ListTile(
                          title:  Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(flex: 5,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Ay", style: TextStyle(fontSize:size.height * ktahsilatoran),),
                                      ],
                                    ),
                                  ),
                                  Expanded(flex: 3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Miktar", style: TextStyle(fontSize:size.height * ktahsilatoran),),
                                      ],
                                    ),
                                  ),
                                  Expanded(flex: 3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Tutar", style: TextStyle(fontSize:size.height * ktahsilatoran),),
                                      ],
                                    ),
                                  ),

                                  ],
                                ),
                              ],
                          ),
                        ),
                      ),
                    ),

                  ],             
                ),
              ),
            ),

            SliverFillRemaining(
              child: SizedBox(
                height: size.height * 0.83,
                child: FutureBuilder<List<CariAylikSatis>>(
                  future: _controller.getCariAylikSatis(ekstre.malzemeKodu),
                  builder: (BuildContext context, AsyncSnapshot<List<CariAylikSatis>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          CariAylikSatis ekstreT;                  
                          ekstreT = snapshot.data[index];

                          return CariSatislarAylikCard(ekstre: ekstreT,);
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
              
              
      ),
      
    );    
    
  }

}