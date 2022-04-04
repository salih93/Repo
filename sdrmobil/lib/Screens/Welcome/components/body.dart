import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sdrmobil/Screens/Login/login_screen.dart';



class Body extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {
    //final Controller _controller = Get.put(Controller());
    // This size provide us total height and width of our screen
    return AnimatedSplashScreen(
      splash: Image.asset(
        'assets/icons/logo.png',
      ),
      nextScreen: LoginScreen(),
      splashTransition: SplashTransition.rotationTransition,  
      splashIconSize:150 ,
      duration: 1,      
    //backgroundColor: Colors.redAccent,
    );


  }
}
