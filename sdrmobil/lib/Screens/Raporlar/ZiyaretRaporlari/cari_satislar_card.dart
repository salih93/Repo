import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/models/Satis/aylik_satis.dart';

class CariSatislarCard extends StatelessWidget {
  const CariSatislarCard({ Key key, @required this.ekstre, this.onTap_}) : super(key: key);
  final CariAylikSatis ekstre;
  final Function onTap_;
  
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);
    final nFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "",symbol: "", decimalDigits: 0);
    var format = NumberFormat.simpleCurrency(locale: myLocale.languageCode);
    initializeDateFormatting(myLocale.languageCode);
    Size size = MediaQuery.of(context).size;    

      return Card(                    
          child:ListTile(
            contentPadding: EdgeInsets.only(left: 5.0, right: 0.0),
            onTap: onTap_,
            leading: null,
            title: Row(                                  
              children: [

              Expanded(
                flex: 1,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.03),
                    child:CachedNetworkImage(
                      imageUrl: ekstre.path,                              
                      imageBuilder: (context, imageProvider) => 
                      Container(
                        width: size.width * 0.18,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,                                      
                            ),
                        ),
                      ),

                      placeholder: (context, url) => Center(child:CircularProgressIndicator(color: Color(0xff009068),),),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
            
                  ],
                ),
              ),

              Expanded(flex: 11,
                child: Column(                          
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    SizedBox(height: size.height * 0.006,),
                    Row(                      
                      children: [
                        
                        Expanded(
                          flex: 8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ekstre.malzemeKodu, style: TextStyle(fontSize:size.height * ktahsilatoran3),),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(nFormat.format(ekstre.miktar) + ' ' + ekstre.birim.toString(), 
                                style: TextStyle(fontSize:size.height * ktahsilatoran3),),
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: size.height * 0.006,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [                                
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AutoSizeText(ekstre.malzemeAdi, 
                                style: TextStyle(fontSize:size.height * ktahsilatoran3,), 
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,                                                           
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(mFormat.format(ekstre.ciro)+ ' '+format.currencySymbol, style: TextStyle(fontSize:size.height * ktahsilatoran3),),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ],
                ),
              ),

            
              

            ],
          ),                  
          trailing: (onTap_!=null) ? Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey,):Text(""),
        ),
      );
      
                
  }
}