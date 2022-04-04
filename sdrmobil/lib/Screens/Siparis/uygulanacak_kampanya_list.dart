import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:sdrmobil/Screens/Siparis/uygulanacak_kampanya_card.dart';
import 'package:sdrmobil/VeritabaniIslemleri/siparis_kampanya_bedelsiz.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_uygulanacak.dart';

class UygulanacakKampanya extends StatelessWidget {
  const UygulanacakKampanya({ Key key }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    final SiparisController _controller =Get.find();
    final Controller mainController =Get.find();

    return WillPopScope(
      onWillPop: () async => false,
      
      child: Scaffold(        
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff009068),
          title: Center(child: Text('Kampanya Listesi', style: TextStyle(color: Colors.white, fontSize: size.width * 0.060),)),
        ),

        body:Obx(()=>Background(
          child: CustomScrollView(
            slivers: [
                     
              SliverFillRemaining(
                  child: FutureBuilder<List<KampanyaUygulanacaklar>>(
                    future: _controller.satilacakmiktar.value>0 ? _controller.getUygulanacakKampanyalar():_controller.getUygulanacakKampanyalar(),
                    builder: (BuildContext context, AsyncSnapshot<List<KampanyaUygulanacaklar>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            KampanyaUygulanacaklar kuygulacak;                  
                            kuygulacak = snapshot.data[index];
                            
                            if (mainController.kampanyaSecili.value==1)
                              kuygulacak.secim=1;

                            return UygulanacakKampanyaCard(item:kuygulacak,index: index,);
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
          ),
        ),),


        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.cancel_rounded,color: Colors.red,),
              label:"İPTAL",                         
            ),            
            BottomNavigationBarItem(icon: Icon(Icons.fact_check,color: Color(0xff009068),),
              label:"UYGULA" ,),
          ],        
          onTap: (int index) async {
            if (index==0) Navigator.of(context).pop();
            if (index==1)
            {
              if (!await KampanyaUygula2().kampanyaGeriAl(_controller.siparissayac.value,context))
              {
                Get.snackbar("Uyarı", "Kampanya geri alınamadı.",backgroundColor: Color(0xff0000), colorText: Color(0xffffff), 
                duration: Duration(seconds: 5),);
                return;
              }

              if (_controller.uygulanacakKampanyalar!=null)
              {
                if (_controller.uygulanacakKampanyalar.length>0)
                {
                  bool result=false;
                  result=await KampanyaUygula2().otomatikKampanyaUygula(context);
                  if(!result)  
                  {                                    
                    snackbar("Hata","Siparişe kampanya uygulanamadı.", Icons.error_sharp);
                    return;
                  }
                }
              }

              _controller.bedelsizkampanyaflag.value=0;
              _controller.yuzdeselkampanyaflag.value=0;
              Navigator.pop(context);
              
            }

 
          },
        ),


      ),
    );

  }
}