import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/models/Satis/aylik_satis.dart';

class CariSatislarAylikCard extends StatelessWidget {
  const CariSatislarAylikCard({ Key key, @required this.ekstre}) : super(key: key);
  final CariAylikSatis ekstre;
  
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
    final nFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "",symbol: "", decimalDigits: 0);

    initializeDateFormatting(myLocale.languageCode);
    Size size = MediaQuery.of(context).size;
    

      return Card(                    
        child:ListTile(
          title:  Column(
            children: [
              Row(
                children: [
                  Expanded(flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ekstre.ayStr, style: TextStyle(fontSize: size.height * ktahsilatoran)),
                      ],
                    ),
                  ),
                  Expanded(flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nFormat.format(ekstre.miktar) + ' ' + ekstre.birim.toString(), 
                          style: TextStyle(fontSize:size.height * ktahsilatoran),),
                      ],
                    ),
                  ),
                  Expanded(flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mFormat.format(ekstre.ciro), style: TextStyle(fontSize:size.height * ktahsilatoran),),
                      ],
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