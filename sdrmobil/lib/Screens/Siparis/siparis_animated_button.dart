
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/Screens/Siparis/siparis_girisi.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:simple_animated_icon/simple_animated_icon.dart';


class SiparisAnimatedButton extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  SiparisAnimatedButton({this.onPressed, this.tooltip, this.icon});

  @override
  _SiparisAnimatedButtonState createState() => _SiparisAnimatedButtonState();
}

class _SiparisAnimatedButtonState extends State<SiparisAnimatedButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  final SiparisController _controller =Get.find();

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,        
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }


  Widget satisSiparisi() {
    Size size = MediaQuery.of(context).size;

    return Container(
      child:Visibility(
        visible: isOpened,
        child: FloatingActionButton.extended(
          heroTag: Text(""),
          onPressed: () async {
            print('Satış Siparişi');
            _controller.siparissayac.value=0;
            _controller.siparisTipi.value="Satış Siparişi";            
            _controller.siparisDate=DateTime.now();
            _controller.siparisTarihiController.text = DateFormat('dd-MM-yyyy').format(_controller.siparisDate);            
            _controller.sevkTarihiController.text="";
            _controller.aciklamaController.text="";
            _controller.update();

            animate();
            isOpened=false;
            await _controller.getCariSube();
            Navigator.of(context).pop();
            
            await _controller.getSatisTipi();
            Get.to(()=>SiparisGirisi());
          },

          tooltip: 'Satış Siparişi',
          label: Row(children: [
            Text('Satış Siparişi', style: TextStyle(fontSize: size.height * ksiparisoran),),
            Icon(Icons.add,color: Colors.white,),
          ]),
          backgroundColor: Color(0xff009068),
        ),
      ),
    );
  }

  //Müşteri İade yapılınca
  // Widget musteriIade() {
  //   return Container(      
  //     child: Visibility(
  //       visible: isOpened,
  //       child:FloatingActionButton.extended(
  //         heroTag: Text("AAAAAAAAA"),
  //         onPressed: (){
  //           print('Müşteri İade');
  //           _controller.siparissayac.value=0;            
  //           _controller.siparisTarihiController.text="";
  //           _controller.sevkTarihiController.text="";
  //           _controller.aciklamaController.text="";
  //           _controller.update();
                                    
  //           animate();
  //           isOpened=false;            
  //           //Get.to(()=>NakitTahsilatiW());
  //         },
          
  //         tooltip: 'Müşteri İade',
  //         label: Row(children: [
  //           Text('Müşteri İade'style: TextStyle(fontSize: size.height * ksiparisoran),),
  //           Icon(Icons.remove,color: Colors.white,),
  //           // ImageIcon(AssetImage("assets/icons/tahsilat.png"),
  //           //   color: Colors.white,),
  //         ]),
  //         backgroundColor: Color(0xff009068),
  //       ),
  //     ),
  //   );
  // }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: Text(""),
        backgroundColor: Color(0xff009068),
        onPressed: animate,
        tooltip: 'Toggle',
        child: SimpleAnimatedIcon(
          startIcon: Icons.add,
          endIcon: Icons.close,
          progress: _animateIcon,
        ),      
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[        
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: satisSiparisi(),
        ),

        //Müşteri İade yapılınca
        // Transform(
        //   transform: Matrix4.translationValues(
        //     0.0,
        //     _translateButton.value,
        //     0.0,
        //   ),
        //   child: musteriIade(),
        // ),
        toggle(),
      ],
    );
  }
}