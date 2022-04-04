
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Tahsilat/kredi_karti_tahsilati.dart';
import 'package:sdrmobil/Screens/Tahsilat/nakit_tahsilat.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/tahsilat_controller.dart';
import 'package:simple_animated_icon/simple_animated_icon.dart';


class TahsilatAnimatedButton extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  TahsilatAnimatedButton({this.onPressed, this.tooltip, this.icon});

  @override
  _TahsilatAnimatedButtonState createState() => _TahsilatAnimatedButtonState();
}

class _TahsilatAnimatedButtonState extends State<TahsilatAnimatedButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  final TahsilatController _controller = Get.put(TahsilatController());

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    // _buttonColor = ColorTween(
    //   begin: Color(0xff009068),
    //   end: Color(0xff009068),
    // ).animate(CurvedAnimation(
    //   parent: _animationController,      
    //   curve: Interval(
    //     0.00,
    //     1.00,        
    //     curve: Curves.linear,
    //   ),
    // ));

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


  Widget kkTahsilati() {
    Size size = MediaQuery.of(context).size;

    return Container(
      child:Visibility(
        visible: isOpened,
        child: FloatingActionButton.extended(
          heroTag: Text(""),
          onPressed: () async {
            print('Kredi Kartı');
            _controller.tahsilatsayac.value=0;
            _controller.fisturu.value="K.Kartı Tahsilatı";
            _controller.kasa.value="";
            _controller.tutarController.text="";
            _controller.makbuzNoController.text="";
            _controller.slipNoController.text="";
            _controller.kKartNoController.text="";
            _controller.aciklamaController.text="";
            _controller.update();
            
            //Navigator.pop(context);
            //Get.off(TahsilatAnaSayfa());
            animate();
            isOpened=false;            
            Get.to(()=>KrediKartiTahsilatiW());
          },
          tooltip: 'Kredi Kartı',
          label: Row(children: [
            Text('Kredi Kartı', style: TextStyle(fontSize: size.height * ktahsilatoran),),
            SizedBox(width: size.width * ktahsilatoran5,),
            Icon(FontAwesome5.credit_card,color: Colors.white,),
          ]),
          backgroundColor: Color(0xff009068),
        ),
      ),
    );
  }

  Widget nakitTahsilat() {
    Size size = MediaQuery.of(context).size;

    return Container(      
      child: Visibility(
        visible: isOpened,
        child:FloatingActionButton.extended(
          heroTag: Text("AAAAAAAAA"),
          onPressed: (){
            print('Nakit Tahsilat');
            _controller.tahsilatsayac.value=0;
            _controller.fisturu.value="Nakit Tahsilat";            
            _controller.kasa.value="";
            _controller.tutarController.text="";
            _controller.makbuzNoController.text="";
            _controller.slipNoController.text="";
            _controller.kKartNoController.text="";
            _controller.aciklamaController.text="";            
            _controller.update();
            
            animate();
            isOpened=false;            
            Get.to(()=>NakitTahsilatiW());
          },
          
          tooltip: 'Nakit Tahsilat',
          label: Row(children: [
            Text('Nakit Tahsilat', style: TextStyle(fontSize:size.height * ktahsilatoran)),
            SizedBox(width: size.width * ktahsilatoran5,),         
            ImageIcon(AssetImage("assets/icons/tahsilat.png"),
              color: Colors.white,),
          ]),
          backgroundColor: Color(0xff009068),
        ),
      ),
    );
  }

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
          //size: size.height * ktahsilatoran4,
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
          child: kkTahsilati(),
        ),
        // SizedBox(width: size.height * ktahsilatoran4,),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: nakitTahsilat(),
        ),
        toggle(),
      ],
    );
  }
}