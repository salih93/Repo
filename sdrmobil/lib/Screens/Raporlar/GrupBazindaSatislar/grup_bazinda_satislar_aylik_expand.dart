
import 'package:flutter/material.dart';
import 'package:sdrmobil/Screens/Raporlar/GrupBazindaSatislar/grup_bazinda_satislar_aylik_card.dart';
import 'package:sdrmobil/constants.dart';

class GrupBazindaSatislarAylikExpand extends StatelessWidget {
  GrupBazindaSatislarAylikExpand(this.malzemeKodu, this.malzemeAdi, this.children);
  final String malzemeKodu;
  final String malzemeAdi;
  final List<GrupBazindaSatislarAylikCard> children;
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 

    return  Card(
      child: new ExpansionTile(        
        key: new PageStorageKey<String>(malzemeKodu),
        initiallyExpanded: true,
        title: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Text(
                  malzemeKodu,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: size.height * kGrupBazindaSatislarBasOran1, fontWeight: FontWeight.bold),
                )),
            Expanded(
                flex: 6,
                child: Text(
                  malzemeAdi,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: size.height * kGrupBazindaSatislarBasOran1, fontWeight: FontWeight.bold),
                )),
          ],
        ),

        children: children,
      ),
    );

  }
}

