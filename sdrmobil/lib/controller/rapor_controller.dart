
import 'dart:core';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/models/Malzeme/grup_list.dart';
import 'package:sdrmobil/models/Malzeme/grup_list_all.dart';
import 'package:sdrmobil/models/Malzeme/malzeme_fiyat.dart';
import 'package:sdrmobil/models/Raporlar/acik_hesap_listesi.dart';
import 'package:sdrmobil/models/Raporlar/grup_bazinda_satislar.dart';
import 'package:sdrmobil/models/Raporlar/gunluk_tahsilat.dart';
import 'package:sdrmobil/models/Raporlar/musteri_mal_analizi_ay.dart';
import 'package:sdrmobil/models/Raporlar/musteri_mal_analizi_mlzmus_toplam.dart';
import 'package:sdrmobil/models/Raporlar/musteri_toplamlari.dart';
import 'package:sdrmobil/models/Raporlar/rut_bazinda_cari.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis_gruplu.dart';
import 'package:sdrmobil/models/Siparis/gunluk_siparis.dart';
import 'package:sdrmobil/models/grup_adi.dart';
import 'package:sdrmobil/providers/db_provider.dart';

class GunlukSiparisToplam {
  double toplamTutar;
  double toplamMiktar; 

  GunlukSiparisToplam({this.toplamMiktar, this.toplamTutar});

  GunlukSiparisToplam.fromJson(Map<String, dynamic> json) {    
    toplamTutar=json['toplamTutar'];      
    toplamMiktar=json['toplamMiktar'];
  }
}


class RaporController extends GetxController {
  RxString rut="TÜMÜ".obs;
  RxString musteriAdi="TÜMÜ".obs;
  RxString mgrup1="TÜMÜ".obs;
  RxString mgrup2="TÜMÜ".obs;
  RxString mgrup3="TÜMÜ".obs;
  RxString depo="TÜMÜ".obs;

  RxString raporRut="TÜMÜ".obs;
  RxString raporMusteriAdi="TÜMÜ".obs;
  RxString raporMgrup1="TÜMÜ".obs;
  RxString raporMgrup2="TÜMÜ".obs;
  RxString raporMgrup3="TÜMÜ".obs;
  RxString raporDepo="TÜMÜ".obs;

  RxInt grupkullan=0.obs;
  RxInt sayac=0.obs;
  RxInt rutsayac=0.obs;
  RxDouble itemMMAanlizi=0.0.obs;
  RxDouble toplamSMiktar=0.0.obs;
  RxDouble toplamSTutar=0.0.obs;
  RxDouble toplamIMiktar=0.0.obs;
  RxDouble toplamITutar=0.0.obs;
  RxDouble toplamNMiktar=0.0.obs;
  RxDouble toplamKdvsiz=0.0.obs;
  RxDouble gunlukTahsilatToplam=0.0.obs;
  RxDouble gunlukSiparisToplam=0.0.obs;

  RxString cariKodu="".obs;
  RxString unvan="".obs;
  RxString cariKodub="".obs;
  RxString unvanb="".obs;

  RxString siparisno="".obs;
  DateTime siparistarihi=DateTime.now();
  RxString siparisasama="".obs;

  RxInt maxIndex=0.obs;
  RxInt endIndex=0.obs;
  
  List<BekleyenSiparisGruplu> bekleyenSiparisMalzemeGrup=<BekleyenSiparisGruplu>[].obs;
  List<RutBazindaCari> cariList=<RutBazindaCari>[].obs;
  List<GrupList> grupListesi=<GrupList>[].obs;
  List<GrupListAll> grupAllList=<GrupListAll>[].obs;
  List<GrupAdi> grup1List=<GrupAdi>[].obs;
  
  List<GrupAdi> depoList=<GrupAdi>[].obs;

    
  DateTime tarih1=DateTime.now();
  DateTime tarih2=DateTime.now();
  
  DateTime raporTarih1=DateTime.now();
  DateTime raporTarih2=DateTime.now();

  TextEditingController tarih1Controller = TextEditingController();
  TextEditingController tarih2Controller = TextEditingController();
  TextEditingController raporTarih1Controller = TextEditingController();
  TextEditingController raporTarih2Controller = TextEditingController();
  
  @override
  void onInit() {
    super.onInit();
  }
  setData(){
    tarih1=DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
    tarih2=DateTime.now();
  
    tarih1Controller.text=DateFormat("dd-MM-yyyy").format(tarih1).toString();
    tarih2Controller.text=DateFormat("dd-MM-yyyy").format(tarih2).toString();
    toplamSMiktar.value=0;
    toplamSTutar.value=0;
    toplamIMiktar.value=0;
    toplamITutar.value=0;
    toplamNMiktar.value=0;
    toplamKdvsiz.value=0;
    cariKodu.value="";
    cariKodub.value="";
    unvan.value="";
    unvanb.value="";
    maxIndex.value=0;
    rut.value="TÜMÜ";
    musteriAdi.value="TÜMÜ";
    mgrup1.value="TÜMÜ";
    mgrup2.value="TÜMÜ";
    mgrup3.value="TÜMÜ";
    
    raporRut.value="TÜMÜ";
    raporMusteriAdi.value="TÜMÜ";
    raporMgrup1.value="TÜMÜ";
    raporMgrup2.value="TÜMÜ";
    raporMgrup3.value="TÜMÜ";
    raporDepo.value="TÜMÜ";


    update();
  }
  setDataDialog(){
    siparisno.value="";
    siparistarihi=DateTime.now();
    siparisasama.value="";

    toplamSMiktar.value=0;
    toplamSTutar.value=0;
    toplamIMiktar.value=0;
    toplamITutar.value=0;
    toplamNMiktar.value=0;
    toplamKdvsiz.value=0;
    cariKodu.value="";
    cariKodub.value="";
    unvan.value="";
    unvanb.value="";
    maxIndex.value=0;
    sayac.value=999;                  
    sayac.value=0;
    update();
  }


  getRutCariListesi() async {
    cariList.clear();
    cariList=await DBProvider.db.getRutCariListesi();
    update();
  }

  getMalzemeGrupListesi() async {

    grupListesi.clear();
    grupListesi=await DBProvider.db.getGrupList();

    grup1List.clear();
    grup1List=await DBProvider.db.getMMGrupList();


    grupAllList.clear();
    grupAllList=await DBProvider.db.getGrupListAll();

    update();
  }

  getDepoListesi() async {

    depoList=<GrupAdi>[];
    depoList=await DBProvider.db.getDepoList();

    update();
  }

  Future<List<MusteriMalAnaliziMlzMusToplam>> getMusteriMalAnalizi() async {
    return await DBProvider.db.getMusteriMalAnalizi();
  }

  Future<List<GrupBazindaSatislarM>> getGrupBazindaSatislar() async {
    return await DBProvider.db.getGrupBazindaSatislar();
  }

  Future<List<MusteriMalAnaliziAy>> getMusteriMalAnaliziAy() async {
    return await DBProvider.db.getMusteriMalAnaliziAy();
  }

  Future<List<MusteriMalAnaliziAy>> getMusteriMalAnaliziAylikGruplu() async {
    return await DBProvider.db.getMusteriMalAnaliziAylikGruplu();
  }

  Future<List<MusteriToplamlari>> getMusteriMalAnaliziToplam() async {
    return await DBProvider.db.getMusteriMalAnaliziToplam();
  }

  getGunlukTahsilatToplam() async {
    List<double> toplamlar;
    toplamlar=await DBProvider.db.getGunlukTahsilatToplam();

    gunlukTahsilatToplam.value=0;
    if (toplamlar.length>0)
    {
      toplamlar.forEach((element) { 
        gunlukTahsilatToplam.value=element;
      });
    }    
    update();
  }

  Future<List<GunlukSiparisToplam>> getGunlukSiparisToplam() async {
    List<GunlukSiparisToplam> toplamlar;
    toplamlar=await DBProvider.db.getGunlukSiparisToplam();    
    return toplamlar;
  }
  
  getMMAnaliziMusCount() async {
    itemMMAanlizi.value=await DBProvider.db.getMMAnaliziMusCount();
  }

  void setMalzemeGrup() {
    final Controller mainController = Get.find();
    
    grupkullan.value=int.parse(mainController.tanimList.firstWhere((element) => element.key=="grup3_kullan").value);
    if (grupkullan.value==0)
    {
      grupkullan.value=int.parse(mainController.tanimList.firstWhere((element) => element.key=="grup2_kullan").value);
      if (grupkullan.value==0)
      {
        grupkullan.value=int.parse(mainController.tanimList.firstWhere((element) => element.key=="grup1_kullan").value);
      }
      else grupkullan.value=2;
    }
    else grupkullan.value=3;
    update();
  }

  void getRaporDegerleri() {
    raporRut.value=rut.value;
    raporMusteriAdi.value=musteriAdi.value;
    raporMgrup1.value=mgrup1.value;
    raporMgrup2.value=mgrup2.value;
    raporMgrup3.value=mgrup3.value;
    raporTarih1=tarih1;
    raporTarih2=tarih2;
    raporTarih1Controller.text=tarih1Controller.text;
    raporTarih2Controller.text=tarih2Controller.text;
    raporDepo.value=depo.value;    
    update();
  }

  void setRaporDegerleri() {
    rut.value=raporRut.value;
    musteriAdi.value=raporMusteriAdi.value;
    mgrup1.value=raporMgrup1.value;
    mgrup2.value=raporMgrup2.value;
    mgrup3.value=raporMgrup3.value;
    tarih1=raporTarih1;
    tarih2=raporTarih2;
    tarih1Controller.text=raporTarih1Controller.text;
    tarih2Controller.text=raporTarih2Controller.text;
    depo.value=raporDepo.value;
    maxIndex.value=0;
    sayac.value=0;
    update();
    sayac.value=999;
    update();
  }

  List<DropdownMenuItem<String>> getDropDownDepo() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    items.add(new DropdownMenuItem(
      value: 'TÜMÜ',
      child: new Text('TÜMÜ'),
      ),
    );   

    depoList.forEach((element) { 
      if (element.grupadi!="BOŞ")
      {
        items.add(new DropdownMenuItem(
          value: element.grupadi,        
          child: new Text(element.grupadi),
          ),
        );
      }
      
    });

    return items;
  }


  List<DropdownMenuItem<String>> getDropDownGrup1() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    items.add(new DropdownMenuItem(
      value: 'TÜMÜ',
      child: new Text('TÜMÜ'),
      ),
    );   

    grup1List.forEach((element) { 
      if (element.grupadi!="BOŞ")
      {
        items.add(new DropdownMenuItem(
          value: element.grupadi,        
          child: new Text(element.grupadi),
          ),
        );
      }
      
    });

    return items;
  }

  List<DropdownMenuItem<String>> getDropDownGrup2() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    items.add(new DropdownMenuItem(
      value: 'TÜMÜ',
      child: new Text('TÜMÜ'),
      ),
    );
    
    grupListesi.forEach((element) { 
      if (element.grupadi1==raporMgrup1.value)
      {
        if (element.grupadi2!="BOŞ")
        {
          items.add(new DropdownMenuItem(
            value: element.grupadi2,        
            child: new Text(element.grupadi2),
            ),
          ); 
        }
      }
    });

    return items;
  }

  List<DropdownMenuItem<String>> getDropDownGrup3() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    items.add(new DropdownMenuItem(
      value: 'TÜMÜ',
      child: new Text('TÜMÜ'),
      ),
    );
    
    grupAllList.forEach((element) { 
      if (element.grupadi2==raporMgrup2.value)
      {
        if (element.grupadi3!="BOŞ")
        {
          items.add(new DropdownMenuItem(
            value: element.grupadi3,        
            child: new Text(element.grupadi3),
            ),
          ); 
        }
      }
    });
    
    return items;
  }


  List<DropdownMenuItem<String>> getDropDownMusteri() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    items.clear();

    items.add(new DropdownMenuItem(
      value: 'TÜMÜ',
      child: new Text('TÜMÜ'),
      ),
    );

    if (raporRut.value=="TÜMÜ")
    {
      cariList.forEach((element) {
        if (items.where((item) => item.value==element.unvan).length==0)
        {
          items.add(new DropdownMenuItem(
            value: element.unvan,
            child: FittedBox(child: Text(element.unvan), fit: BoxFit.contain,),
            ),
          );
        }
        
      });
    }
    else
    {
      cariList.where((item) => (item.gun==raporRut.value)).forEach((element) {
        items.add(new DropdownMenuItem(
          value: element.unvan,
          child: new Text(element.unvan, overflow: TextOverflow.ellipsis),
          ),
        );
      });
    }

    return items;
  }

  List<DropdownMenuItem<String>> getDropDownRutlar() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];

    items.add(
      DropdownMenuItem(            
        value: 'TÜMÜ',
        child: Text('TÜMÜ'),
      ),
    );


    items.add(new DropdownMenuItem(
      value: 'Pazartesi',
      child: new Text('Pazartesi'),
      ),
    );
    items.add(new DropdownMenuItem(
      value: 'Salı',
      child: new Text('Salı'),
      ),
    );
    items.add(new DropdownMenuItem(
      value: 'Çarşamba',
      child: new Text('Çarşamba'),
      ),
    );

    items.add(new DropdownMenuItem(
      value: 'Perşembe',
      child: new Text('Perşembe'),
      ),
    );
    items.add(new DropdownMenuItem(
      value: 'Cuma',
      child: new Text('Cuma'),
      ),
    );
    items.add(new DropdownMenuItem(
      value: 'Cumartesi',
      child: new Text('Cumartesi'),
      ),
    );
    items.add(new DropdownMenuItem(
      value: 'Pazar',
      child: new Text('Pazar'),
      ),
    );

    //raporMusteriAdi.value="TÜMÜ";
    update();

    return items;
  }

  Future<List<AcikHesapListesi>> getAcikHesapListesi() async {    
    return await DBProvider.db.getAcikHesapListesi();
  }

  Future<List<GunlukTahsilat>> getGunlukTahsilat() async {    
    return await DBProvider.db.getGunlukTahsilat();
  }
  Future<List<GunlukSiparis>> getGunlukSiparis() async {    
    return await DBProvider.db.getGunlukSiparis();
  }

  Future<List<BekleyenSiparis>> getAllBekleyenSiparis() async {    
    return await DBProvider.db.getAllBekleyenSiparis();
  }

  Future<List<MalzemeFiyat>> getStokFiyatListesi() async
  {
    
    if (bekleyenSiparisMalzemeGrup.length==0)
    {
      bekleyenSiparisMalzemeGrup.clear();
      bekleyenSiparisMalzemeGrup = await DBProvider.db.getBekleyenSiparisGruplu(1);
      update();
    }

    int rowNum=0;
    List<MalzemeFiyat> list;        
    list= await DBProvider.db.getRStokFiyatListesi();
    if (list.length>0)
    {
      list.forEach((element) { 
        rowNum++;
        element.rowNum=rowNum;
      });
    }
    
    return list; 
  }  

}