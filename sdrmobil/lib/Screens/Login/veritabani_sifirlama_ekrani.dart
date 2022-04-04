
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/controller/controller.dart';

class VeritabaniSifirlamaW extends StatelessWidget {
  const VeritabaniSifirlamaW({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final Controller _controller = Get.put(Controller());
    Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width * 0.96,
        child:
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("Bu işlem tüm aktarılmamış verilerin kaybolmasına sebep olacaktır. Devam etmek istediğinizden emin misiniz?",
                        //style: TextStyle(fontSize:size.width * 0.036,), 
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),                
              ],
            ),

            Row(
              children: [
                Expanded(child:Column( 
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,                     
                    children: [
                      Padding(padding: EdgeInsets.only(top: 5),
                        child: Text('Cevabınızı yazın(Evet/Hayır): ',),
                      ),                        
                    ],
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(flex: 2,
                child:
                  Column( 
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,                     
                    children: [
                      TextField(
                        controller: _controller.veritabaniGuncelle,                        
                        showCursor: true,
                        decoration: InputDecoration(          
                          hintText: "Cevabınız",                          
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey[400]),                        
                        ),                      
                      ),
                    ],
                  ),                                        
                ),
              ],
            ),
            

          ],
        ),

    );
    

  }
 
}

