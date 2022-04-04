import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir_list.dart';
class SiparisSepetiCardRow2 extends StatelessWidget {
  const SiparisSepetiCardRow2({Key key, this.item }) : super(key: key);
  final SiparisSatirList item;

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
    Size size = MediaQuery.of(context).size;
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);
    
    return Row(children: [
      Expanded(flex: 3,                                
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(flex: 2,          
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tutar:", style: TextStyle(fontSize: size.height * ksiparisoran5),),
                      ],
                    ),
                  ),

                  Expanded(flex: 2,          
                    child:Column(children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(mFormat.format(item.tutar)+' '+format.currencySymbol, 
                            style: TextStyle(color: Colors.blue[800], fontSize: size.height * ksiparisoran5),),
                        ),
                      ],
                    ), 
                  ),
                ],
              ),

            ],
          ),
        ),

        // Text("İnd. Tutar:", style: TextStyle(fontSize: size.height * ksiparisoran5),),
        // Text(mFormat.format(item.toplamindirim)+' '+format.currencySymbol, style: TextStyle(color: Colors.blue[800], fontSize: size.height * ksiparisoran5),),


      Expanded(flex: 2,                                
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(children: [
                Text("Kdv :", style: TextStyle(fontSize: size.height * ksiparisoran5),),
                (item.kdvorani * 100) % 100>0 ? 
                  Text('%' + mFormat.format(item.kdvorani), 
                    style: TextStyle(color: Colors.blue[800], fontSize: size.height * ksiparisoran5),):
                  Text('%' + item.kdvorani.toStringAsFixed(0), 
                    style: TextStyle(color: Colors.blue[800], fontSize: size.height * ksiparisoran5),)
              ],),                                                                 
            ],
          ),
        ),

      Expanded(flex: 3,                                
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(flex: 2,          
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("T.Tutar:", style: TextStyle(fontSize: size.height * ksiparisoran5),),
                      ],
                    ),
                  ),

                  Expanded(flex: 2,          
                    child:Column(

                      children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child:Text(mFormat.format(item.satirtutari) + ' '+format.currencySymbol, style: TextStyle(color: Colors.blue[800], fontSize: size.height * ksiparisoran5),),
                        ),

                      ],
                    ), 
                  ),
                ],
              ),

            ],
          ),
        ),


      ],
    );
                                

  }
}