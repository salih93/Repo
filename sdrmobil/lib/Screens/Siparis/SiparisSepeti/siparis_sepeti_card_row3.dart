import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir_list.dart';
class SiparisSepetiCardRow3 extends StatelessWidget {
  const SiparisSepetiCardRow3({Key key, this.item }) : super(key: key);
  final SiparisSatirList item;

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    final nFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "",symbol: "", decimalDigits: 0);
    Size size = MediaQuery.of(context).size;
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);
    
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [                              
          Expanded(                                
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    Text('İndirimler: ',style: TextStyle(fontSize: size.height * ksiparisoran),),
                    Text(item.indirim01flag>0 ? ' %' + nFormat.format(item.iskontotutari1):'0',
                      style: TextStyle(fontSize: size.height * ksiparisoran),),
                    Text(item.indirim02flag>0 ? ';%' + nFormat.format(item.iskontotutari2):';0',
                      style: TextStyle(fontSize: size.height * ksiparisoran),),
                    Text(item.indirim03flag>0 ? ';%' + nFormat.format(item.iskontotutari3):';0',
                      style: TextStyle(fontSize: size.height * ksiparisoran),),
                    Text(item.indirim04flag>0 ? ';%' + nFormat.format(item.iskontotutari4):';0',
                      style: TextStyle(fontSize: size.height * ksiparisoran),),
                    Text(item.indirim05flag>0 ? ';%' + nFormat.format(item.iskontotutari5):';0',
                      style: TextStyle(fontSize: size.height * ksiparisoran),),
                    Text(item.indirim06flag>0 ? ';%' + nFormat.format(item.iskontotutari6):';0',
                      style: TextStyle(fontSize: size.height * ksiparisoran),),

                    Text(" (" + nFormat.format(item.toplamindirim)+' ' +format.currencySymbol + ')', style: TextStyle(color: Colors.blue[800], fontSize: size.height * ksiparisoran),),                           

                ]),
              ],
            ),
          ),                             
        ],
      );

                                

  }
}