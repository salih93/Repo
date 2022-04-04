
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:sdrmobil/Screens/Tahsilat/tahsilat_ana_sayfa_cart.dart';
import 'package:sdrmobil/Screens/Tahsilat/tahsilat_animated_button.dart';
import 'package:sdrmobil/Screens/Ziyaret/cari_hareket.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/tahsilat_controller.dart';
import 'package:sdrmobil/models/Tahsilat/tahsilat.dart';


class TahsilatAnaSayfa extends StatelessWidget {
  const TahsilatAnaSayfa({Key key }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TahsilatController _controller = Get.put(TahsilatController());
    
 
  return Obx(()=>WillPopScope(
      onWillPop: () async => false,
    child: Scaffold(      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff009068),          
        title: Text('Tahsilatlar', style: TextStyle(fontSize: size.height * kRaporOranBaslik),),
        leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
          iconSize: size.height * kRaporFiltereOran,
          onPressed:(){            
            Navigator.of(context).pop();            
            Get.to(()=>CariHareket());
          },
        ),

        actions: [
          Row(              
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Padding(padding:EdgeInsets.only(right: 10) ,child: Image.asset(
                  'assets/images/sdr-upbar-logo-icon.png',
                  fit: BoxFit.contain,
                  height: size.height * 0.05,                  
                ),
                ),
              ],
            ),
          ],
        ),

        body: Background(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(          
                    height: size.height * 0.85,
                    width: size.width * 0.96,
                    child: FutureBuilder<List<Tahsilat>>(
                      // tahsilatnumber değişince her türlü güncellesin diye.               
                      future: (_controller.tahsilatnumber.value>0)? _controller.getTahsilat():
                      _controller.getTahsilat(),

                      builder: (BuildContext context, AsyncSnapshot<List<Tahsilat>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(                          
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              Tahsilat tahsilat;
                              tahsilat = snapshot.data[index];

                              return TahsilatAnaSayfaCard(tahsilat: tahsilat);
                                                          
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
        

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:Container(
          padding: EdgeInsets.only(left: size.width * 0.50),            
          child:TahsilatAnimatedButton(
            onPressed: () {},
            tooltip: 'Increment',
            icon: Icons.add,            
          ),
        ), 
      ),
  ),

    );
  }
}
