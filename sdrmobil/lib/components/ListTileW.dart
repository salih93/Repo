
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';

class ListTileW extends StatelessWidget {
  final IconData icon;
  final String baslik;
  final Color renk;
  final String sayfa;
  final Function onTop;

  ListTileW(
      {Key key,
      this.icon = Icons.person,
      this.baslik = "",
      this.renk = Colors.black,
      this.sayfa = "",
      this.onTop}):super(key:key);

  @override
  Widget build(BuildContext context) {
    final Controller _controller = Get.find();
    Size size = MediaQuery.of(context).size;
    
    return ListTile(
      // leading: Image(
      //   image: AssetImage("assets/images/menu/" + sayfa + ".png"),
      // ),
      leading: Icon(this.icon, color: renk,),
      enabled: !(_controller.ziyaretId.value>0 && sayfa=="aktarimlar") && !(_controller.aktarilmamisZiyaret.value>0 && sayfa=="musteriziyaret"),
      title: Text(baslik, style: TextStyle(fontSize: size.height * kDrawerMenuOran)),
      onTap: onTop,

    );
  }
}
