import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';


class SiparisSepetiToplamW extends StatelessWidget {
  const SiparisSepetiToplamW({
    Key key,  
    this.tutar=0,
    this.indirimtutari=0,
    this.kdv=0,
    this.toplamtutar=0
  }) : super(key: key);
  final double tutar;
  final double indirimtutari;
  final double kdv;
  final double toplamtutar;

  
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    final noSimbolInUSFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      symbol: "");
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);
    
    Size size = MediaQuery.of(context).size;
    
    return Card(
      color: Colors.green[50],
      child: ListTile( 
        contentPadding:EdgeInsets.only(left: 5, right: 0.0),
        title: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Tutar',
                      style: TextStyle(fontSize:size.height * ksiparisoran5),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('İnd.Tutarı',
                      style: TextStyle(fontSize:size.height * ksiparisoran5),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Kdv',
                      style: TextStyle(fontSize:size.height * ksiparisoran5),
                    ),

                  ],
                ),
              ),
              
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Toplam Tutar',
                      style: TextStyle(fontSize:size.height * ksiparisoran5),
                    ),
                  ],
                ),
              ),
                           
                
            ],
          ),
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                Expanded(
                  flex: 6,
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: Text(noSimbolInUSFormat.format(tutar)+' '+format.currencySymbol,
                      style: TextStyle(fontSize:size.height * ksiparisoran5),
                      ),
                  ),
                ),

                Expanded(
                  flex: 6,
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: Text(noSimbolInUSFormat.format(indirimtutari)+' '+format.currencySymbol,
                      style: TextStyle(fontSize:size.height * ksiparisoran5),
                      ),
                  ),
                ),

                Expanded(
                  flex: 6,
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: Text(noSimbolInUSFormat.format(kdv)+' '+format.currencySymbol,
                      style: TextStyle(fontSize:size.height * ksiparisoran5),
                    ),
                  ),
                ),

                Expanded(
                  flex: 7,
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: Text(noSimbolInUSFormat.format(toplamtutar)+' '+format.currencySymbol,
                      style: TextStyle(fontSize:size.height * ksiparisoran5),
                    ),
                  ),
                ),           
            ],
          ),          
                
        ],
         
      ),
      ),
   );
  }
}