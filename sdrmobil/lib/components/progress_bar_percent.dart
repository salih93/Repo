import 'package:flutter/material.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sdrmobil/constants.dart';

class ProgressPercentIndicator extends StatelessWidget {
ProgressPercentIndicator({Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff009068),title: Text("SDR Mobil", 
                    style: TextStyle(color: Colors.white, fontSize: size.height * kSdrMobilOran),
                    ),
          ),

      body: Background(child:CircularPercentIndicator(
                radius: size.width * 0.30,                
                animation: true,
                animationDuration: 1000,
                restartAnimation: true,
                lineWidth: size.width * 0.03,
                percent: 1,
                center: new Text(
                   //_controller.yuzdeYuzuzerinden.value.toString(),
                   "Loading...",
                  style:new TextStyle(fontWeight: FontWeight.bold, fontSize: size.width * 0.05),
                ),
                circularStrokeCap: CircularStrokeCap.round,                
                progressColor: Color(0xff009068),              

              ),
        ),      
    );
      
    
  }
}