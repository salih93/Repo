import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sdrmobil/Screens/Welcome/components/body.dart';

class WelcomeScreen extends StatelessWidget { 
   
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,        
      ]);
      
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
