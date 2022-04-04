
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:sdrmobil/Screens/Map/map_screen.dart';
import 'package:sdrmobil/Screens/Ziyaret/cari_hareket.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';


class ZiyaretBaslat extends StatefulWidget {

  @override
  State<ZiyaretBaslat> createState() => _ZiyaretBaslatState();
}

class _ZiyaretBaslatState extends State<ZiyaretBaslat> {
  final Controller _controller = Get.find();
      

  @override
  void initState() {
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,    
    ]);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title:Text("Ziyaret Başlatıyorsunuz", style: TextStyle(color: Colors.white),),
          backgroundColor: Color(0xff009068),
          automaticallyImplyLeading: false,
        ),

        body:
          Background(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            
          children: [          
            Padding(
              padding: EdgeInsets.only(top: 5,left: size.width * 0.035,right: size.width * 0.035),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,            
                children: [            
                  Expanded(
                    flex: 1,             
                    child: Column(
                      children: [
                        Center(
                          child: Icon(Icons.account_balance_rounded, color: Colors.green,size: size.height * 0.05,),
                        )
                      ],
                    ),
                  ),

                  Expanded(
                      flex: 5,                  
                      child:Container(                      
                        margin: EdgeInsets.only(top: 5,left:size.width * 0.03,right: size.width * 0.03),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.end,
                                children: [                          
                                Text(DateFormat.Hm().format(DateTime.now()).toString(),
                                style: TextStyle(fontSize: size.height * kziyaretbaslatoran1),textAlign:TextAlign.end,),                                                    
                              ],
                            ),
                            SizedBox(height: size.height * 0.005,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    _controller.rut.value.unvan.toString(),
                                    style: TextStyle(fontSize: size.height * kziyaretbaslatoran1),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: size.height * 0.005,),
                            Padding(
                              padding: const EdgeInsets.only(top : 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [                        
                                Container(
                                    alignment: Alignment.topRight,
                                    //Giriş-Markete km eklenecek.
                                    child: Obx(()=> Text("Giriş-Market:"+ _controller.mesafe.value, 
                                      style: TextStyle(fontSize: size.height * kziyaretbaslatoran1),),),
                                  ),
                                ],
                              ),
                            ),
                          ],             
                        ),
                      ),           
                    ),
                  ],
              ),
            ),

            SizedBox(height: size.height * 0.01),

            Padding(
              padding: EdgeInsets.only(top: 5,left:size.width * 0.035,right: size.width * 0.035),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,            
                children: [
                  Container(
                      height: size.height * 0.65,
                      width: size.width * 0.90,
                      child: MapScreen(onlyLocation: 0,),
                    ),
                ],

              ),
            ),

            SizedBox(height: size.height * 0.01),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                //Padding(child: EdgeInsets.only(top: 5),),
                Expanded(                
                    flex: 1,
                    child: Container(
                      child: Column(                  
                      mainAxisAlignment: MainAxisAlignment.center,                
                      children: [
                        Center(
                          child: Icon(Icons.location_pin, color: Colors.blueGrey,
                          size: 40,),
                        ),                    
                      ],
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.01,),

                Expanded(
                    flex: 5,
                    child: Container(
                      child: Column(
                        
                        children: [                        
                            Row(children: [
                                Container(child: Text("Konum", style: TextStyle(fontSize: size.height * kziyaretbaslatoran1,
                                  fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                            Row(children: [
                                Container(child: Text("Noktanın önünde ve açık alanda olmalısınız.", style: TextStyle(fontSize: size.height * kziyaretbaslatoran1),),
                                ),
                              ],
                            ),
                            Row(children: [
                                Container(child: Text("Hatasız konum için 20 saniye bu alanda bekleyiniz.", style: TextStyle(fontSize: size.height * kziyaretbaslatoran1),),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01,),
                            Row(
                              children: [
                                Expanded(flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [                                    
                                      SizedBox(                                      
                                        height: size.height * 0.035,
                                        width: size.width * 0.30,
                                        child: TextButton(
                                        style: TextButton.styleFrom(                                        
                                          textStyle: TextStyle(fontSize: size.height * kziyaretbaslatoran3),
                                          backgroundColor: Color(0xffC79E35),                                                                            
                                        ),
                                        onPressed: (){                                        
                                          //Get.to(()=>ZiyaretGunleri());
                                          Get.back();
                                        },                                      
                                        child: Text(
                                          "İPTAL",
                                          style: TextStyle(color: Colors.white),                                    
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                                Expanded(flex: 1, 
                                child: Column(children: [                              
                                      SizedBox(
                                        height: size.height * 0.035,
                                        width: size.width * 0.30,
                                          child: TextButton(
                                            child: Text(
                                              "ZİYARET BAŞLAT",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                                                                
                                            style: TextButton.styleFrom(                                            
                                                textStyle: TextStyle(fontSize: size.height * kziyaretbaslatoran3),
                                                backgroundColor: Colors.blue,
                                              ),
                                            onPressed: () async {
                                              _controller.startProgress();
                                              if(_controller.ziyaretId.value==0)
                                              {
                                                if (await _controller.girisIslemleri(_controller.carikod.value)!=true)
                                                {
                                                  _controller.stopProgress(context);
                                                  snackbar("Hata", _controller.hata.value.toString(), Icons.error);
                                                  return;
                                                }
                                              }
                                              else
                                              {
                                                _controller.stopProgress(context);
                                                snackbar("uyarı", "Aktif ziyaretinizi sonlandırmalısınız.", Icons.error);
                                                return;
                                              }
                                              Navigator.of(context).pop();
                                              _controller.stopProgress(context);
                                              
                                              Get.to(()=> CariHareket());
                                            },
                                          
                                          ),
                                        ),                                   
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                      ),
                    ),
                ),

              ],

            ),
          ],
        ),
        
      ),
      ),
    );
  }

  

} 