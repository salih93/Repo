

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pie_chart/pie_chart.dart' as pi;
import 'package:sdrmobil/Screens/Program/components/size_helper.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/models/Satis/satis_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({
    Key key,
    @required this.context,
    @required this.imageUrl,
    @required this.temsilciAdi,
    @required this.firmaAdi,    
    @required this.ziyaretOzetDataMap,    
    @required this.gunlukSiparisTutar,
    @required this.gunlukFaturaTutar,
    @required this.gunlukTahsilatTutar,    
    @required this.satischart,
  }) : super(key: key);

  final BuildContext context;
  final String imageUrl;
  final String temsilciAdi;
  final String firmaAdi;  
  final Map<String, double> ziyaretOzetDataMap;  
  final double gunlukSiparisTutar;
  final double gunlukFaturaTutar;
  final double gunlukTahsilatTutar;  
  final List<SatisChart> satischart;
  

  @override
  Widget build(BuildContext context) {    
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 1, top: 0),
      child: Stack(
        children: [
          Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,        
          children: [
            
            Card(
              child: Container(
                height: displayHeight(context) * 0.18,
                child: row1(
                  imageUrl,
                  temsilciAdi,
                  firmaAdi,
                  context
                ),
              ),
            ),
            
          
            Card(
              child:Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: displayWidth(context) * 0.025),                        
                        height: displayHeight(context) * 0.02,
                        child: Text("Ziyaretler Özeti", style: TextStyle(color: Colors.grey, fontSize: size.height * kZiyaretOran),),                      
                      ),
                      Container(
                        height: displayHeight(context) * 0.18,
                        child: chartZiyaret(ziyaretOzetDataMap, context),
                      ),

                    ],
                  ),
                ],
              ),
              
            ),

            
            Card(
              child: Container(
                height: displayHeight(context) * 0.10,
                child: row3(
                    gunlukSiparisTutar, gunlukFaturaTutar, gunlukTahsilatTutar, context),
              ),
            ),

            // Divider(
            //   color: Colors.white,
            //   height: 1,
            // ),
            Card(
              child: Container(
                height: displayHeight(context) * 0.40,
                child: chartSatis(satischart),
              ),
            ),
            

          ],
         ),
        ],

      ),
    );
  }

  

}


Widget chartZiyaret(Map data, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PieChart(
      dataMap: data,
      centerText: "",       
      chartType: ChartType.disc,
      
      //chartLegendSpacing: kChartLegendSpacing,
      colorList: [Colors.blue, Colors.green, Colors.red, Colors.orange],
      chartValuesOptions: ChartValuesOptions(
        chartValueStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: size.height * kScreenOran),
        showChartValuesInPercentage: false,
        showChartValues: false,
        showChartValueBackground: false,
        showChartValuesOutside: true,        
        decimalPlaces: 0,        
      ),
      legendOptions: LegendOptions(
        showLegendsInRow: false,        
        legendPosition: pi.LegendPosition.left,        
        legendTextStyle:
            TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: size.height * kZiyaretOran),        
        showLegends: true,
      ),
      animationDuration: Duration(milliseconds: 2000),
    );
  }

  Widget chartSatis(List<SatisChart> data) {
    return Center(
      child: Container(
        child: SfCartesianChart(
          // Enables the tooltip for all the series in chart
          //tooltipBehavior: _tooltipBehavior,
          // Initialize category axis
          primaryXAxis: CategoryAxis(
            labelRotation: 270,
          ),
          series: <ChartSeries>[
            // Initialize line series

            ColumnSeries<SatisChart, String>(
                dataSource: data,
                color: Colors.amber,
                xValueMapper: (SatisChart data, _) => data.unvan,
                yValueMapper: (SatisChart data, _) => data.gunlukSiparisTutar),
            LineSeries<SatisChart, String>(
                enableTooltip: true,
                color: Colors.purple,
                dataSource: data,
                xValueMapper: (SatisChart sales, _) => sales.unvan,
                yValueMapper: (SatisChart sales, _) =>
                    sales.gunlukTahsilatTutar),

            BubbleSeries<SatisChart, String>(
                enableTooltip: true,
                color: Colors.red,
                dataSource: data,
                xValueMapper: (SatisChart sales, _) => sales.unvan,
                yValueMapper: (SatisChart sales, _) => sales.gunlukFaturaTutar),
            // Render line series
          ],
        ),
      ),
    );
  }

  Widget row1(String imageUrl, String temsilciAdi, String firmaAdi, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: temsilciResim(imageUrl, context),
        ),
        SizedBox(width: size.width * 0.010,),
        Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [temsilciBilgi(temsilciAdi, Colors.green, context)],
                  ),
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    temsilciBilgi(firmaAdi, Colors.grey, context),
                  ],
                ),
              ],
            )),
      ],
    );
  }

  Widget row2(String text) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 8,
            child: Column(
              children: [
                Text(text),
              ],
            )),
      ],
    );
  }

  Widget row3(double gunlukSiparisTutar, double gunlukFaturaTutar,
      double gunlukTahsilatTutar, BuildContext context) {
     Locale myLocale = Localizations.localeOf(context);
    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);

      
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Column(
              children: [
                myContainerWidget(
                    "Siparişler", Colors.amber, Colors.white, Colors.amber, context),

                myContainerWidget(mFormat.format(gunlukSiparisTutar), Colors.white,
                    Colors.black, Colors.amber, context),
                 
              ],
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                myContainerWidget(
                    "Faturalar", Colors.red, Colors.white, Colors.red, context),                
                myContainerWidget(mFormat.format(gunlukFaturaTutar), Colors.white,
                    Colors.black, Colors.red, context),
              ],
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                myContainerWidget(
                    "Tahsilatlar", Colors.purple, Colors.white, Colors.purple, context),
                myContainerWidget(mFormat.format(gunlukTahsilatTutar), Colors.white,
                    Colors.black, Colors.purple, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget row4(String text) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 8,
            child: Column(
              children: [
                Text(text),
              ],
            )),
      ],
    );
  }

  Widget temsilciBilgi(String text, Color renk, BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Expanded(      
      child: Container(
        child: FittedBox(
          fit: text.length>27 ? BoxFit.cover: BoxFit.none,
          child: Text(
            text,
            style: TextStyle(color: renk, fontWeight: FontWeight.bold, fontSize: size.height * kZiyaretOran),
          ),
        ),
      ),
    );
  }

  Widget temsilciResim(String imageUrl, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    if (imageUrl != "" && imageUrl != null) {
      //burada networkten
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: size.width * 0.1512,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            width: size.width * 0.80,
            height: size.height * 0.80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,              
              image: DecorationImage(
                  image: imageProvider, 
                  fit: BoxFit.cover
              ),
            ),
          ),
          placeholder: (context, url) =>
              Center(child:CircularProgressIndicator(color: Color(0xff009068),),),

          errorWidget: (context, url, error) => 
            Container(
              width: size.width * 0.80,
              height: size.height * 0.80,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          "assets/images/menu/temsilci.png"),
                          ),
                        ),
                    ),                      
        ),
      );      

    } else {
      return Container(
        width: size.width * 0.80,
        height: size.height * 0.80,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/menu/temsilci.png"),
            ),
        ),
      );
      //Image(image: AssetImage('assets/images/menu/temsilci.png'));
    }
  }

  Widget myContainerWidget(    
      String text, Color backrounColor, Color textColor, Color borderColor, BuildContext context) {
      Size size = MediaQuery.of(context).size;

    return Container(
      decoration: myBoxDecoration(backrounColor, borderColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Text(text,
                textAlign: TextAlign.center, style: TextStyle(color: textColor, fontSize: size.height * kZiyaretOran)),
          )
        ],
      ),
    );    
  }

  BoxDecoration myBoxDecoration(Color backroundCoolor, Color borderColor) {
    return BoxDecoration(
      color: backroundCoolor,
      border: Border.all(
        color: borderColor, //                   <--- border color
        width: 1.0,
      ),
      // borderRadius: BorderRadius.all(
      //     Radius.circular(5.0) //                 <--- border radius here
      //     ),
    );
  }
