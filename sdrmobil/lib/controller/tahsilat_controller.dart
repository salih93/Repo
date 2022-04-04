import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/models/Tahsilat/kasa_kod_value.dart';
import 'package:sdrmobil/models/Tahsilat/tahsilat.dart';
import 'package:sdrmobil/models/Ziyaret/ziyaret.dart';
import 'package:sdrmobil/models/Ziyaret/ziyaret_sonlandirma_tipleri.dart';
import 'package:sdrmobil/providers/db_provider.dart';

class TahsilatController extends GetxController {
  final Controller mainController = Get.find();

  RxString kasa="".obs;
  RxString fisturu = "".obs;
  RxInt tahsilatsayac=0.obs;
  RxInt tahsilatnumber=0.obs;
  RxInt ziyaretSonlandirmaTipiSayac=0.obs;
  RxInt zorunluaciklama=0.obs; 
  List<ZiyaretSonlandirmaTipleri> ziyaretSonlandirmaTipleri=<ZiyaretSonlandirmaTipleri>[];
  
  final FocusNode focusNode=FocusNode();
  final FocusNode mkfocusNode=FocusNode();
  final FocusNode knfocusNode=FocusNode();  

  final TextEditingController tutarController = new TextEditingController();
  final TextEditingController makbuzNoController = new TextEditingController();
  final TextEditingController slipNoController = new TextEditingController();
  final TextEditingController kKartNoController = new TextEditingController();  
  final TextEditingController aciklamaController = new TextEditingController();
  final TextEditingController aciklamaZController = new TextEditingController();
  final TextEditingController ziyaretSonlandirmaTipi = new TextEditingController();

  final SlidableController tahsilatSlidableCont = new SlidableController();
  

  @override
  void onInit() {
    tutarController.text="";
    makbuzNoController.text="";
    slipNoController.text="";
    kKartNoController.text="";
    aciklamaController.text="";
    aciklamaZController.text="";
    
    //klavye için yapılmıştı.
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   focusNode.requestFocus();      
    // });
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   mkfocusNode.requestFocus();
    // });    
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   knfocusNode.requestFocus();
    // });
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   tutarController.addListener(() {
    //     focusNode.requestFocus();
    //     tutarController.selection = TextSelection.fromPosition(
    //         TextPosition(offset: tutarController.text.length));
    //   });
    // });

    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    // makbuzNoController.addListener(() {
    //   mkfocusNode.requestFocus();  
    //   makbuzNoController.selection = TextSelection.fromPosition(
    //       TextPosition(offset: makbuzNoController.text.length));
    //   });
    // });    
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   kKartNoController.addListener(() {
    //     knfocusNode.requestFocus();
    //     kKartNoController.selection = TextSelection.fromPosition(
    //         TextPosition(offset: kKartNoController.text.length));
    //   });
    // });   
    

    super.onInit();
  }

  @override
  void onClose() {            
    super.onClose();
    focusNode.dispose();
    mkfocusNode.dispose();
  }


  Future<List<KasaKodValue>> getKasa(int krediKartiKasasi) async {
    List<KasaKodValue> kKasa=<KasaKodValue>[];
    kKasa=await DBProvider.db.getKasa(krediKartiKasasi);

    if (kKasa.length==1)
    {
      
      kKasa.forEach((element) { 
        kasa.value=element.sorumlu.toString();
      });
      update();
    }
    else
    {
      kasa.value="";
    }

    return kKasa;
  }

  Future<String> deleteTahsilat(int rsayac) async {
    String tahsilatlar;
      tahsilatlar=await DBProvider.db.deleteTahsilat(rsayac);

    return tahsilatlar;
  }

  Future<List<Tahsilat>> getTahsilat() async {
    List<Tahsilat> tahsilatlar;
      //tahsilatlar=await DBProvider.db.getTahsilat(mainController.carikod.value, mainController.ziyaretId.value);

      tahsilatlar=await DBProvider.db.getTahsilat(mainController.carikod.value);

    return tahsilatlar;
  }

  Future<List<Tahsilat>> getAllTahsilat() async {
    List<Tahsilat> tahsilatlar;
      tahsilatlar=await DBProvider.db.getAllTahsilat();

    return tahsilatlar;
  }

  Future<List<Ziyaret>> getAllZiyaret() async {
    List<Ziyaret> ziyaretler;
      ziyaretler=await DBProvider.db.getAllZiyaret();
      
    return ziyaretler;
  }

  Future<int> getZiyaretSonlandirmaTipiSayac(String ziyaretSonlandirmaTipi) async {
      int sayac=0;
      sayac=await DBProvider.db.getZiyaretSonlandirmaTipiSayac(ziyaretSonlandirmaTipi);
      
    return sayac;
  }

  getSiparisTahsilatKontrol() async {
    Controller _mainController = Get.find();
    
    ziyaretSonlandirmaTipleri.clear();
    ziyaretSonlandirmaTipleri=<ZiyaretSonlandirmaTipleri>[];    
    ziyaretSonlandirmaTipleri =await DBProvider.db.getSiparisTahsilatKontrol(_mainController.ziyaretId.value);

    for (ZiyaretSonlandirmaTipleri item in ziyaretSonlandirmaTipleri) {
      ziyaretSonlandirmaTipiSayac.value=item.rsayac;
      ziyaretSonlandirmaTipi.text=item.tipi;
      break;     
    }
  }

  List<DropdownMenuItem<String>> getZiyaretDropDownMenu() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    ziyaretSonlandirmaTipleri.forEach((element) { 
       items.add(new DropdownMenuItem(
          value: element.tipi,
          child: new Text(element.tipi),
          ),
        );
    });

    return items;
  }



}