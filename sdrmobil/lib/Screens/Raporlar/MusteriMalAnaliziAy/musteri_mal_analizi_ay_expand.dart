
import 'package:flutter/material.dart';
import 'package:sdrmobil/Screens/Raporlar/MusteriMalAnaliziAy/musteri_mal_analizi_ay_card.dart';
import 'package:sdrmobil/constants.dart';

class MusteriMalAnaliziAyExpand extends StatelessWidget {
  MusteriMalAnaliziAyExpand(this.musteriKodu, this.unvan, this.children);
  final String musteriKodu;
  final String unvan;
  final List<MusteriMalAnaliziCardAy> children;
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Card(
      child: new ExpansionTile(        
        key: new PageStorageKey<String>(musteriKodu),
        initiallyExpanded: true,
        title: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Text(
                  musteriKodu,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: size.height * kMusteriMalBasOran),
                )),
            Expanded(
                flex: 6,
                child: Text(
                  unvan,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: size.height * kMusteriMalBasOran),
                )),
          ],
        ),

        children: children,
      ),
    );

  }
}

