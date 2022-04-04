import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:sdrmobil/Screens/Siparis/SiparisSepeti/siparis_sepeti.dart';
import 'package:sdrmobil/Screens/Siparis/siparis_urun_listesi.dart';
import 'package:sdrmobil/Screens/Siparis/siparisler.dart';
import 'package:sdrmobil/Screens/Siparis/uygulanacak_kampanya_list.dart';
import 'package:sdrmobil/VeritabaniIslemleri/siparis_kampanya_bedelsiz.dart';
import 'package:sdrmobil/VeritabaniIslemleri/siparis_kampanya_uygula.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
class SiparisGirisiUrun extends StatelessWidget {
  const SiparisGirisiUrun({Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final SiparisController _controller =Get.find();
    final Controller mainController =Get.find();

    _controller.tabController.animateTo(_controller.sepetiac.value);

    return Background(
      child: DefaultTabController(

          length: 2,
          child: Obx(()=>WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(size.height * 0.12),
                  child: AppBar(
                    backgroundColor: Color(0xff009068),
                    title: Text('Sipariş Girişi', style: TextStyle(color: Colors.white, fontSize: size.height * kRaporOranBaslik),),
                    automaticallyImplyLeading: false,
                    
                    leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
                      iconSize: size.height * kRaporFiltereOran,
                      onPressed:() async {

                        if (_controller.siparissayac.value>0)
                        {
                          if (await _controller.getSiparisSatirCount(_controller.siparissayac.value)==0)
                          {
                            await _controller.deleteSiparis(_controller.siparissayac.value);
                            await _controller.getSiparisListCount(0);
                          }
                          else
                          {
                            bool bCancel=false;
                            await Get.defaultDialog(
                              title: "Dikkat",            
                              backgroundColor: Colors.white,
                              titleStyle: TextStyle(color: Colors.red),
                              middleTextStyle: TextStyle(color: Colors.black),                                
                              textConfirm: "Evet",
                              textCancel: "Hayır",
                              cancelTextColor: Colors.black,
                              confirmTextColor: Colors.black,                            
                              radius: 1,                
                              content: Text("Siparişten çıkmak istediğinizden emin misiniz?",                               
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2),
                              barrierDismissible: false,
                              onConfirm: () async {

                                if (await _controller.getOnaysizSiparisCount(_controller.siparissayac.value)>0)
                                {
                                  await _controller.deleteSiparis(_controller.siparissayac.value);
                                  await _controller.getSiparisListCount(0);
                                }

                                Navigator.maybeOf(context).pop();                            
                              },
                              onCancel: () {
                                bCancel=true;

                              }
                            );

                            if (bCancel) return;

                          }

                          _controller.sGuid.value="";
                          _controller.siparissatirrsayac.value=0;
                          _controller.siparissayac.value=0;
                        }            
                        Navigator.of(context).pop();            
                        Get.to(()=>Siparisler());
                      },
                    ),

                    //centerTitle: true,
                    actions: [                    
                      Padding(
                        //padding: EdgeInsets.all(size.height * 0.006),
                        padding: EdgeInsets.only(bottom:size.height * 0.005, top: size.height * 0.001),
                        child: Visibility(
                          visible: _controller.sepetKaydetButton.value==true ? true:false,
                          child: TextButton(            
                            style: ButtonStyle( 
                              fixedSize: MaterialStateProperty.all(Size(size.width * 0.18, size.height * 0.01)),

                              backgroundColor: MaterialStateProperty.all(Color(0xff009068)), 
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Colors.white)
                                ),
                              ),                              
                            ),

                            child: Text("Kaydet", style: TextStyle(color: Colors.white, fontSize: size.height * ksiparisoran,),),
                            onPressed: () async {                            
                              if (_controller.siparissayac.value>0)
                              {
                                mainController.startProgress();
                                _controller.uygulanacakKampanyalar.clear();
                                _controller.siparisIndirim.clear();
                                _controller.bedelsizkampanyaflag.value=0;
                                _controller.yuzdeselkampanyaflag.value=0;
                                _controller.sepetKaydetButton.value=false;
                                _controller.update();

                                if (mainController.bedelsizKampanya.value==1 || mainController.yuzdeselKampanya.value==1)
                                {
                                  if (!await KampanyaUygula().kampanyaUygula(_controller.siparissayac.value, context))
                                  {
                                    snackbar("Hata","Siparişe kampanya uygulanamadı.", Icons.error_sharp);
                                    _controller.sepetKaydetButton.value=true;
                                    mainController.stopProgress(context);
                                    return;
                                  }
                                }
                                
                                if (_controller.uygulanacakKampanyalar.length>0)
                                {
                                  int kampanyaOtomatik=0;
                                  kampanyaOtomatik=_controller.kampanyaOtomatik(_controller.satisTipikodu.value);
                                  if (kampanyaOtomatik==1)
                                  {
                                    for (var item in _controller.uygulanacakKampanyalar) {
                                      if (item.bedelsizkampanyaflag==1)                                    
                                        if (item.satilacakmiktar==0){kampanyaOtomatik=0; break; }
                                    }
                                    if (kampanyaOtomatik==1)                                
                                    {
                                      _controller.uygulanacakKampanyalar.forEach((item) { 
                                        item.secim=1;
                                      });
                                    }
                                  }                                

                                  if (kampanyaOtomatik==1)                                
                                  {
                                    if (!await KampanyaUygula2().kampanyaGeriAl(_controller.siparissayac.value,context))
                                    {
                                      Get.snackbar("Uyarı", "Kampanya geri alınamadı.",backgroundColor: Color(0xff0000), colorText: Color(0xffffff), 
                                      duration: Duration(seconds: 5),);
                                      _controller.sepetKaydetButton.value=true;
                                      mainController.stopProgress(context);
                                      return;
                                    }
                                    
                                    bool result=false;
                                    result=await KampanyaUygula2().otomatikKampanyaUygula(context);
                                    if(!result)  
                                    {                                    
                                      snackbar("Hata","Siparişe kampanya uygulanamadı.", Icons.error_sharp);
                                      _controller.sepetKaydetButton.value=true;
                                      mainController.stopProgress(context);
                                      return;
                                    }
                                  }
                                  
                                  if (kampanyaOtomatik==0)
                                  {
                                    mainController.stopProgress(context);
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const UygulanacakKampanya()),
                                    );                   
                                  }
                                }
                                else
                                {
                                  if (!await KampanyaUygula2().kampanyaGeriAl(_controller.siparissayac.value,context))
                                  {
                                    Get.snackbar("Uyarı", "Kampanya geri alınamadı.",backgroundColor: Color(0xff0000), colorText: Color(0xffffff), 
                                    duration: Duration(seconds: 5),);
                                    _controller.sepetKaydetButton.value=true;
                                    mainController.stopProgress(context);
                                    return;
                                  }
                                }

                                await _controller.siparisOnayla(_controller.siparissayac.value);
                              }
                              _controller.siparissayac.value=1;
                              _controller.siparissatirrsayac.value=0;
                              _controller.siparissayac.value=0;
                              _controller.bedelsizkampanyaflag.value=0;
                              _controller.yuzdeselkampanyaflag.value=0;
                              _controller.bedelsizptr.value="";
                              _controller.update();           
                                                
                              mainController.stopProgress(context);
                              Navigator.pop(context);                            
                              Get.to(()=>Siparisler());
                            },

                          ),
                        ),
                      ),        
                    ],


                    bottom: TabBar(
                      controller: _controller.tabController,                    
                      onTap: (value) {                    
                        if (value==0)
                        {
                          _controller.sepetKaydetButton.value=false;
                          _controller.isSearching.value=false;
                          _controller.searchController.text="";
                          _controller.sonacilanGrup.value="";
                          _controller.update();
                        }                        
                        else
                        {
                          _controller.sepetKaydetButton.value=true;
                          _controller.sonacilanGrup.value="";
                          _controller.update();
                        }                        
                      },

                      tabs: [
                        Tab(                      
                            child:Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(Icons.shopping_basket_outlined, color: Colors.white,size: size.height * ksiparisoran,),
                                SizedBox(width: size.width * 0.01,),
                                Text("Sipariş Girişi", style: TextStyle(fontSize: size.height * ksiparisoran),),
                              ],
                            ),                                           
                        ),

                        Tab(                                            
                            child:Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart_outlined,color: Colors.white,size: size.height * ksiparisoran,),
                              SizedBox(width: size.width * 0.01,),
                              Text(_controller.kayitsayisi.value>0 ? "Sepet(" + _controller.kayitsayisi.toString() + ")":"Sepet", 
                                style: TextStyle(fontSize: size.height * ksiparisoran),),
                            ],
                          ),                   
                        ),

                      ],
                    ),              
                  ),
                ),

                body: TabBarView(
                  controller: _controller.tabController,                
                  children: [                  
                    SiparisUrunList(),
                    SiparisSepeti(),                
                  ],
                ),
              ),
          ),
          ),
        ),       
      );
    

  }
}