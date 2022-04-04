
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/models/Cari/cari_sube.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_bedelsiz_satir.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_uygulanacak.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_yuzdesel_satir.dart';
import 'package:sdrmobil/models/Satis/rut_listesi.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis_grup.dart';
import 'package:sdrmobil/models/Malzeme/birim_cevrimi.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis_gruplu.dart';
import 'package:sdrmobil/models/Siparis/siparis_indrim.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir.dart';
import 'package:sdrmobil/models/Ziyaret/ziyaret.dart';
import 'package:sdrmobil/models/Ziyaret/ziyaret_sonlandirma_tipleri.dart';
import 'package:sdrmobil/models/grup_adi.dart';
import 'package:sdrmobil/models/Malzeme/malzeme_fiyat.dart';
import 'package:sdrmobil/models/Satis/satis_tipi.dart';
import 'package:sdrmobil/models/Siparis/siparis.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir_list.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir_toplam.dart';
import 'package:sdrmobil/providers/db_provider.dart';
class YeniListe {
  final String grupname;
  final int index;
  bool isExpanded;
  List<MalzemeFiyat> children;

  YeniListe(this.grupname, this.children, this.index, this.isExpanded);
}

class BekleyenSiparisGrup{
  final int siparisno;
  final String unvan;
  final String temsilciadi;
  final DateTime siparistarihi;
  final double tutar;
  final double miktar;
  final int uruncesidi;
  final String aciklama;

  List<BekleyenSiparis> children = [];

  BekleyenSiparisGrup(this.siparisno,this.unvan, 
              this.temsilciadi, 
              this.siparistarihi, 
              this.tutar, 
              this.miktar, 
              this.children, 
              this.uruncesidi,
              this.aciklama);
}

class SiparisGrup{
  final int siparisno;
  final String musterino;
  final String unvan;
  final String temsilciadi;
  final DateTime siparistarihi;
  final double tutar;
  final double miktar;
  final int uruncesidi;
  final String aciklama;
  final String satistipiadi;

  List<SiparisSatir> children = [];

  SiparisGrup(this.siparisno,this.unvan, 
              this.temsilciadi, 
              this.siparistarihi, 
              this.tutar, 
              this.miktar, 
              this.children, 
              this.uruncesidi,
              this.aciklama,
              this.musterino,
              this.satistipiadi);
}

// ignore: deprecated_member_use
class SiparisController extends GetxController with SingleGetTickerProviderMixin {  
  RxString siparisTipi="".obs;
  RxString satisTipi = "".obs;
  RxString satisTipikodu = "".obs;
  RxString siparisTarihi="".obs;
  RxString sevkTarihi="".obs;
  RxString siparisBirimi="".obs;
  RxString bedelsizptr="".obs;
  RxString sonacilanGrup="".obs;

  DateTime siparisDate=DateTime.now();
  DateTime sevkDate=DateTime.now();  
  
  RxDouble tutar=0.0.obs;
  RxDouble kdvTutari=0.0.obs;
  RxDouble indirimTutari=0.0.obs;
  RxDouble toplamaTutar=0.0.obs;
  RxDouble satilacakmiktar=0.0.obs;  
  

  Uint8List picture;  
  RxString sGuid="".obs;
  RxBool isDisable=true.obs;
  RxBool sepetKaydetButton=false.obs;

  RxInt selectedIndex = 0.obs;
  RxInt siparissayac=0.obs;  
  RxInt siparissatirrsayac=0.obs;
  RxInt grupkullan=0.obs;
  RxInt kayitsayisi=0.obs;
  RxInt sepetiac=0.obs;
  RxInt siparisOnay=0.obs;
  RxInt bedelsizkampanyaflag=0.obs;
  RxInt yuzdeselkampanyaflag=0.obs;
  RxInt siparisSecim = 0.obs;
  RxString subekodu="".obs;
  RxString subeadi="".obs;
  
  List<YeniListe> data = <YeniListe>[].obs;
  List<YeniListe> filtereddata = <YeniListe>[].obs;
  List<YeniListe> filteredList = <YeniListe>[].obs;
  List<MalzemeFiyat> malzemeDetay=<MalzemeFiyat>[].obs;
  List<SiparisIndirim> siparisIndirim=<SiparisIndirim>[].obs;
  List<GrupAdi> malzemeGrup=<GrupAdi>[].obs;
  List<SatisTipi> satisTipleri=<SatisTipi>[].obs;
  List<KampanyaUygulanacaklar> uygulanacakKampanyalar=<KampanyaUygulanacaklar>[].obs;

  RxBool isSearching = false.obs;
  MalzemeFiyat secilenUrun;

  List<BekleyenSiparisGrup> siparisGrup = <BekleyenSiparisGrup>[].obs;
  List<BekleyenSiparisGrupAdi> bekleyenSiparisGrup=<BekleyenSiparisGrupAdi>[].obs;
  List<BekleyenSiparis> bekleyenSiparisDetay=<BekleyenSiparis>[].obs;
  List<BekleyenSiparisGruplu> bekleyenSiparisMalzemeGrup=<BekleyenSiparisGruplu>[].obs;
  List<CariSube> cariSubeler=<CariSube>[];

  RxString prevCiskonto1 = "0".obs;
  RxString prevCiskonto2 = "0".obs;
  RxString prevCiskonto3 = "0".obs;
  RxString prevCiskonto4 = "0".obs;
  RxString prevCiskonto5 = "0".obs;
  RxString prevCiskonto6 = "0".obs;
  RxString prevCfiyat = "0".obs;
  RxString prevCmiktar = "0".obs;
  RxInt rowNum=0.obs;

  final TextEditingController siparisTarihiController = new TextEditingController();
  final TextEditingController sevkTarihiController = new TextEditingController();  
  final TextEditingController aciklamaController = new TextEditingController();
  final TextEditingController searchController = new TextEditingController();

  final TextEditingController ciskonto1 = new TextEditingController();  
  final TextEditingController ciskonto2 = new TextEditingController();
  final TextEditingController ciskonto3 = new TextEditingController();
  final TextEditingController ciskonto4 = new TextEditingController();
  final TextEditingController ciskonto5 = new TextEditingController();
  final TextEditingController ciskonto6 = new TextEditingController();

  final TextEditingController cfiyat = new TextEditingController();
  final TextEditingController cmiktar = new TextEditingController();
  final TextEditingController ctutar = new TextEditingController();
  final TextEditingController cindirimlitutar = new TextEditingController();
  final TextEditingController ctoplamtutar = new TextEditingController();  
  final TextEditingController cbirim = new TextEditingController();
  final TextEditingController csatiraciklama = new TextEditingController();
  final SlidableController siparisslidableCont=new SlidableController();
  final SlidableController sepetslidableCont=new SlidableController();

  List<Map<String, dynamic>> itemsExpand = List.generate(
      10,
      (index) => {
    'id': index,
    'title': 'Item $index',
    'description':
    'This is the description of the item $index. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    'isExpanded': false
  });
  
  
  // final mFormat = new NumberFormat.currency(locale: "tr",
  //     name: "",symbol: "", decimalDigits: 2);

  TabController tabController;

  @override
  void onInit() {        
    siparisTarihiController.text="";
    sevkTarihiController.text="";
    aciklamaController.text="";

    tabController = TabController(vsync: this, length: 2);
    
    super.onInit();
  }

    Future<List<SatisTipi>> getSatisTipi() async {

    satisTipleri=await DBProvider.db.getSatisTipi();

    if (satisTipleri.length>0)
    { 
      SatisTipi satisTip=satisTipleri.first;     
      satisTipi.value=satisTip.satistipi;
      satisTipikodu.value=satisTip.satistipid;
    }
    else
    {
      satisTipi.value="";
      satisTipikodu.value="";
    }

    update();
    return satisTipleri;
  }

  Future<List<SatisTipi>> getSatisTipleri() async {
    return satisTipleri;
  }
    
  void onItemTapped(int index) async {  
    selectedIndex.value = index;
    // if (index==1)
    // {
    //   await bekleyenGrupDoldur();
    // }

    update();  
  }

  // List<SiparisGrup> siparisGrup = <SiparisGrup>[].obs;
  // List<BekleyenSiparisGrupAdi> bekleyenSiparisGrup=<BekleyenSiparisGrupAdi>[].obs;
  // List<BekleyenSiparis> bekleyenSiparisDetay=<BekleyenSiparis>[].obs;

  bekleyenSiparisGruplu() async {
    bekleyenSiparisMalzemeGrup.clear();
    bekleyenSiparisMalzemeGrup = await DBProvider.db.getBekleyenSiparisGruplu(0);

    update();  
  }

  
  uzakSiparisZiyaretSonlandir(int ziyaretId) async {

    List<ZiyaretSonlandirmaTipleri> ziyaretsonlist= await DBProvider.db.getSiparisTahsilatKontrol(ziyaretId);
    if (ziyaretsonlist.length>0)
    {
      ZiyaretSonlandirmaTipleri ziyaretson=ziyaretsonlist.first;
      if (ziyaretson.sira!=1 && ziyaretson.sira!=7 && ziyaretson.sira!=5)
      {
        await DBProvider.db.deleteFrom("Delete from Ziyaret Where id=${ziyaretId.toString()}");
      }
      
      if (ziyaretson.sira==1 || ziyaretson.sira==7 || ziyaretson.sira==5)
      {
        Ziyaret ziyaret=await DBProvider.db.getZiyaretId(ziyaretId);
        if (ziyaret!=null)
        {
          ziyaret.ziyaretsonlandirmatipisayac=ziyaretson.rsayac;
          ziyaret.endlatitude=ziyaret.startlatitude;
          ziyaret.endlongitude=ziyaret.startlongitude;
          ziyaret.isziyaretactive=0;
          ziyaret.enddate=DateTime.now();
          ziyaret.aciklama="Uzak Sipariş";
          if (ziyaret.rutdetaysayac>0)
          {
            List<RutListesi> rutdetay = await DBProvider.db.getGunRutListesi();
            rutdetay.where((item) => item.rutDetaySayac==ziyaret.rutdetaysayac).forEach((element) {
              ziyaret.faturatoplam=element.gunlukFaturaTutar;
              ziyaret.siparistoplam=element.gunlukSiparisTutar;
              ziyaret.tahsilattoplam=element.gunlukTahsilatTutar;
            });
          }
          await DBProvider.db.updateZiyaret(ziyaret);
        }
      }
      
    }

  }

  Future<List<BekleyenSiparisGrupAdi>> bekleyenGrupDoldur() async {
    
    siparisGrup=<BekleyenSiparisGrup>[];
    bekleyenSiparisDetay=<BekleyenSiparis>[];
    bekleyenSiparisGrup=<BekleyenSiparisGrupAdi>[];


    bekleyenSiparisDetay = await DBProvider.db.getBekleyenSiparisDetay();
    bekleyenSiparisGrup = await DBProvider.db.getbekleyenSiparisGrup();
    siparisGrup = <BekleyenSiparisGrup>[].obs;

    bekleyenSiparisGrup.forEach((item) {
    siparisGrup.add(
        BekleyenSiparisGrup(item.siparisno,
          item.unvan,
          item.temsilciadi,
          item.siparistarihi,
          item.tutar,
          item.miktar, 
          bekleyenSiparisfilter(item.siparisno),
          0,""));
    });

    return bekleyenSiparisGrup;
  }

  Future<List<SiparisGrup>> siparisGrupDoldur() async {
    
    List<SiparisGrup> siparisGrup=<SiparisGrup>[];
    List<SiparisSatir> siparisDetay=<SiparisSatir>[];
    List<Siparis> siparis=<Siparis>[];

    siparisDetay = await DBProvider.db.getSiparisDetay();
    siparis = await DBProvider.db.getSiparisTumList();
    siparisGrup = <SiparisGrup>[];

    siparis.forEach((item) {
      siparisGrup.add(
        SiparisGrup(item.siparisno,
          item.unvan,
          item.satistemsilcisi,
          item.siparistarihi,
          item.toplamtutar,
          item.toplammiktar,
          siparisDetay.where((element) => element.musrsayac == item.rsayac).toList(),
          item.uruncesidi,
          item.aciklama,
          item.musterino,
          item.satistipiadi
        ));
    });

    return siparisGrup;
  }

  List<BekleyenSiparis> bekleyenSiparisfilter(int siparisno) {
    
    List<BekleyenSiparis> list;
    list=bekleyenSiparisDetay.where((element) => element.siparisno == siparisno).toList();
    return list;
  }
  

  malzemeDoldur(int siparisSecimi) async {
    List<YeniListe> eskidata=<YeniListe>[];
    if (siparisSecimi==1)
    {
      eskidata=data;
    }
    
    malzemeDetay.clear(); 
    malzemeGrup.clear();

    malzemeDetay = await DBProvider.db.getMalzemeList();
    malzemeGrup = await DBProvider.db.getMalzemeGrup();    
    int i=0;
    data = <YeniListe>[].obs;
    bool bExpanded=false;

    //    malzemeGrup.forEach((item) async {
    await Future.forEach(malzemeGrup, (GrupAdi item) async
    { 
      if (eskidata.where((element) => element.grupname==item.grupadi && element.isExpanded).length>0)
      {
        bExpanded=true;
      }
      else
      {
        bExpanded=false;
      }

      List<MalzemeFiyat> malzemeList=<MalzemeFiyat>[];       
      await filter(item.grupadi, malzemeList);
      data.add(        
        YeniListe(item.grupadi, malzemeList, i, bExpanded)
      );

      i=i + 1;
    });
    if (eskidata.length>0)
    {
      eskidata.clear();
    }

  }

  filterMalzeme(value) async {      
      List<MalzemeFiyat> temp=malzemeDetay;

      if (value!=null && value!="")
      {
        temp = malzemeDetay
          .where((element) =>
              element.malzemekodu.toLowerCase().contains(value.toLowerCase()) ||
              element.malzemeadi.toLowerCase().contains(value.toLowerCase()) ||
              element.grupadi1.toLowerCase().contains(value.toLowerCase()) ||
              element.grupadi2.toLowerCase().contains(value.toLowerCase()) ||
              element.grupadi3.toLowerCase().contains(value.toLowerCase())
              )
          .toList();
      }

      filteredList = <YeniListe>[].obs;
      List gruplar = [];

      temp.forEach((element) {
        if (!gruplar.contains(element.grupadi)) {
          gruplar.add(element.grupadi);          
        }
      });

      int i=0;
      for (var item in gruplar) {
        await Future.delayed(Duration(milliseconds: 1), () {          
          filteredList.add(          
            YeniListe(item.toString(),
              temp.where((element) =>            
              element.grupadi == item.toString()).toList(), i, false
            )            
          );

          i=i + 1;
        }

        );
      }
      
      
  }

  Future<List<SiparisSatirToplam>> getSiparisToplam(int siparissayac) async
  {   
    return await DBProvider.db.getSiparisToplam(siparissayac);
  }

  Future<List<SiparisSatirList>> getSiparisList() async{   
    rowNum.value=0;
    List<SiparisSatirList> list=await DBProvider.db.getSiparisList(0);
    list.forEach((element) { 
      rowNum.value++;
      element.rowNum=rowNum.value;
    });    
    return list;    
  }

  Future<List<Siparis>> getAllSiparis() async{       
    List<Siparis> list=await DBProvider.db.getAllSiparis();    
    return list;
  }

  Future<List<Siparis>> getSiparisTumList() async{       
    List<Siparis> list=await DBProvider.db.getSiparisTumList();    
    return list;
  }

  Future<List<Siparis>> getAktarilacakSiparis() async{       
    List<Siparis> list=await DBProvider.db.getAktarilacakSiparis();    
    return list;
  }
  Future<List<SiparisSatir>> getAktarilacakSiparisSatir() async{       
    List<SiparisSatir> list=await DBProvider.db.getAktarilacakSiparisSatir();    
    return list;
  }


  Future<List<MalzemeFiyat>> filter(String grupadi, List<MalzemeFiyat> malzemeList) async {
    int rowNum=0; 
    List<MalzemeFiyat> list;
    list=malzemeDetay.where((element) => element.grupadi.toLowerCase().trim() == grupadi.toLowerCase().trim()).toList();
    
    if (list.length>0)
    {
       await Future.forEach(list, (MalzemeFiyat element) async
        {
          double yuzdeselindirim=100;
          String bedelsizGrupAdi="";
          
          KampanyaYuzdeselSatir yuzdeselSatir=await getKampanyaYuzdeselMalzeme(element.malzemekodu);      
                
          yuzdeselindirim=yuzdeselSatir.indirim01>0 ? (yuzdeselindirim * ((100 - yuzdeselSatir.indirim01)/100)):yuzdeselindirim;
          yuzdeselindirim=yuzdeselSatir.indirim02>0 ? (yuzdeselindirim * ((100 - yuzdeselSatir.indirim02)/100)):yuzdeselindirim;
          yuzdeselindirim=yuzdeselSatir.indirim03>0 ? (yuzdeselindirim * ((100 - yuzdeselSatir.indirim03)/100)):yuzdeselindirim;
          yuzdeselindirim=yuzdeselSatir.indirim04>0 ? (yuzdeselindirim * ((100 - yuzdeselSatir.indirim04)/100)):yuzdeselindirim;
          yuzdeselindirim=yuzdeselSatir.indirim05>0 ? (yuzdeselindirim * ((100 - yuzdeselSatir.indirim05)/100)):yuzdeselindirim;
          yuzdeselindirim=yuzdeselSatir.indirim06>0 ? (yuzdeselindirim * ((100 - yuzdeselSatir.indirim06)/100)):yuzdeselindirim;
          yuzdeselindirim=yuzdeselindirim>0 ? (100 - yuzdeselindirim):yuzdeselindirim;

          KampanyaBedelsizSatir bedelsizSatir=await getKampanyaBedelsizMalzeme(element.malzemekodu);
          bedelsizGrupAdi=bedelsizSatir.grupAdi;
          bedelsizGrupAdi= bedelsizGrupAdi==null ? "":bedelsizGrupAdi;

          rowNum++;
          element.rowNum=rowNum;
          element.bedelsizGrupAdi=bedelsizGrupAdi;
          element.yuzdeselindirim=yuzdeselindirim;

          malzemeList.add(element);
        });

    }
   

    return malzemeList;
  }


  setSatisTpiKodu(String satistipi) async{
    satisTipikodu.value=await DBProvider.db.getSatisTipiKodu(satistipi);
    update();
  }
String getDecimalSeparator(String locale) {
  return numberFormatSymbols[locale]?.DECIMAL_SEP ?? "";
}


  void setIskonto(String iskontotutari, int iskontoNo, BuildContext context) {

    Locale myLocale = Localizations.localeOf(context);    
    var decimal=getDecimalSeparator(myLocale.languageCode);
    String iskontotutar;

     if (decimal!=".")
      iskontotutar=iskontotutari.replaceAll('.', ',').trim();
     else
      iskontotutar=iskontotutari.trim();


    if (iskontoNo==1)  
      ciskonto1.text=iskontotutar;
    if (iskontoNo==2)  
      ciskonto2.text=iskontotutar;
    if (iskontoNo==3)  
      ciskonto3.text=iskontotutar;
    if (iskontoNo==4)  
      ciskonto4.text=iskontotutar;
    if (iskontoNo==5)  
      ciskonto5.text=iskontotutar;

    if (iskontoNo==6)  
      ciskonto6.text=iskontotutar;
      
    update();
  }


  String getTutar(String tutar, BuildContext context) {

    Locale myLocale = Localizations.localeOf(context);    
    var decimal=getDecimalSeparator(myLocale.languageCode);

    String valueTutar;
    if (tutar=="")
    {
      valueTutar="0";
    }
    else
    {
      if (decimal!=".")
        valueTutar=tutar.replaceAll('.', decimal).trim();
      else
        valueTutar=tutar.trim();
    }

    return valueTutar;
  }

  String setTutar(String tutar, BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);    
    var decimal=getDecimalSeparator(myLocale.languageCode);

    String valueTutar;
    if (tutar=="")
    {
      valueTutar="0";
    }
    else
    {
      if (decimal!=".")
      {
        valueTutar=tutar.replaceAll('.', '').trim();
        valueTutar=valueTutar.replaceAll(decimal, '.').trim();
      }
      else
      {
        valueTutar=tutar.replaceAll(',', '').trim();
        valueTutar=valueTutar.trim();
      }

      if (valueTutar[0]==".")
        valueTutar="0" + valueTutar;

      if (valueTutar[valueTutar.length - 1]==".")
        valueTutar=valueTutar + "0";
        
    }

    return valueTutar;
  }

  Future<List<BirimCevrimi>> getBirimCevrimi(String malzemekodu) async {

    List<BirimCevrimi> birimcevrimi=<BirimCevrimi>[];
    birimcevrimi=await DBProvider.db.getBirimCevrimi(malzemekodu);
    if (siparisBirimi.value=="" || siparisBirimi.value==null)
    {
      birimcevrimi.forEach((element) { 
        if (element.anabirim==1)
        {
          siparisBirimi.value=element.birimden;
          update();        
        }
      });
    }

    return birimcevrimi;

  }

  getSiparisListCount(int output) async {    
    kayitsayisi.value=await DBProvider.db.getSiparisListCount(output);
    update();
    return kayitsayisi.value;
  }
  
  Future<bool> setTutarHesapla(List<String> ciskonto, String cbirimFiyat, String cmiktar, BuildContext context) async {
    double iskonto1=0;
    double iskonto2=0;
    double iskonto3=0;
    double iskonto4=0;
    double iskonto5=0;
    double iskonto6=0;
    double birimfiyat=0;
    double miktar=0;
    double indirimlitutar=0;
    
    tutar.value=0;
    kdvTutari.value=0;
    indirimTutari.value=0;
    toplamaTutar.value=0;
    indirimlitutar=0;
    Locale myLocale = Localizations.localeOf(context);
    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);

    birimfiyat=double.parse(setTutar(cbirimFiyat,context));
    miktar=double.parse(setTutar(cmiktar,context));

    iskonto1=double.parse(setTutar(ciskonto[0].toString(),context));
    iskonto2=double.parse(setTutar(ciskonto[1].toString(),context));
    iskonto3=double.parse(setTutar(ciskonto[2].toString(),context));
    iskonto4=double.parse(setTutar(ciskonto[3].toString(),context));
    iskonto5=double.parse(setTutar(ciskonto[4].toString(),context));
    iskonto6=double.parse(setTutar(ciskonto[5].toString(),context));    

    tutar.value=(birimfiyat * miktar);  
    indirimlitutar=tutar.value;
    ctutar.text=mFormat.format(tutar.value);

    double indirimlitutartmp=tutar.value;
    if (iskonto1>0) 
    {
      if (secilenUrun.indirim01flag==1)
        indirimTutari.value=((indirimlitutar * iskonto1)/100.0); 
      else
        indirimTutari.value=iskonto1;

      indirimlitutar=indirimlitutar - indirimTutari.value;
    }
    if (iskonto2>0)  
    {
      if (secilenUrun.indirim02flag==1)
        indirimTutari.value=indirimTutari.value + ((indirimlitutar * iskonto2)/100.0); 
      else
        indirimTutari.value=indirimTutari.value + iskonto2;

      indirimlitutar=indirimlitutartmp - indirimTutari.value;
    }
    if (iskonto3>0)  
    {
      if (secilenUrun.indirim03flag==1)
        indirimTutari.value=indirimTutari.value + ((indirimlitutar * iskonto3)/100.0); 
      else
        indirimTutari.value=indirimTutari.value + iskonto3;

      indirimlitutar=indirimlitutartmp - indirimTutari.value;
    }
    if (iskonto4>0)
    {
      if (secilenUrun.indirim04flag==1)
        indirimTutari.value=indirimTutari.value + ((indirimlitutar * iskonto4)/100.0); 
      else
        indirimTutari.value=indirimTutari.value + iskonto4;

      indirimlitutar=indirimlitutartmp - indirimTutari.value;
    }

    if (iskonto5>0)
    {
      if (secilenUrun.indirim05flag==1)
        indirimTutari.value=indirimTutari.value + ((indirimlitutar * iskonto5)/100.0); 
      else
        indirimTutari.value=indirimTutari.value + iskonto5;

      indirimlitutar=indirimlitutartmp - indirimTutari.value;
    }
    if (iskonto6>0)
    {
      if (secilenUrun.indirim06flag==1)
        indirimTutari.value=indirimTutari.value + ((indirimlitutar * iskonto6)/100.0); 
      else
        indirimTutari.value=indirimTutari.value + iskonto6;

      indirimlitutar=indirimlitutartmp - indirimTutari.value;
    }

    String tutarIndirimli=mFormat.format(indirimlitutar);
    indirimlitutar=double.parse(setTutar(tutarIndirimli, context));

    if (indirimlitutar<0)
    {
      snackbar("Uyarı", 
        "Toplam tutar sıfırın altına düşmektedir, lütfen indirimleri kontrol ediniz. Toplam Tutar: $indirimlitutar ", Icons.person);
      return false;
    }

    kdvTutari.value=(indirimlitutar * secilenUrun.kdvorani)/100.0;
    String kdvformatTutar=mFormat.format(kdvTutari.value);    
    kdvTutari.value=double.parse(setTutar(kdvformatTutar, context));

    toplamaTutar.value=indirimlitutar + kdvTutari.value;

    cindirimlitutar.text=mFormat.format(indirimlitutar);
    ctoplamtutar.text=mFormat.format(toplamaTutar.value);
    
    update();

    return true;    
  }

  Future<double> getbirimBolenBolunen(String malzemekodu,String birimden, String birime, String cvalue, BuildContext context) async {    
    double value=0;

    value=double.parse(setTutar(cvalue, context));
    if (value>0)
    {
      value=await DBProvider.db.getBirimCarpanValue(malzemekodu, birimden, birime, value, true);
      if (value==0)
      {
        snackbar("Hata","Malzeme Kodu: $malzemekodu malzeme için, Birimden :$birimden ile Birime :$birime ilişki tanımlanmamış." , Icons.person);
        return 0;
      }
    }
    
    return value;
  }

  Future<bool> tutarHesapla(BuildContext context) async {
    List<String> ciskonto=<String>[];
    ciskonto.add(ciskonto1.text);
    ciskonto.add(ciskonto2.text);
    ciskonto.add(ciskonto3.text);
    ciskonto.add(ciskonto4.text);
    ciskonto.add(ciskonto5.text);
    ciskonto.add(ciskonto6.text);    
    
    return await setTutarHesapla(ciskonto, cfiyat.text, cmiktar.text, context);
  }

  String isNull(String number, String value){
    return (number==null || number=="") ? value:number;
  }

  bool iskontoKontrol(String iskonto, int iskontono, BuildContext context) {
    String iskonto1=isNull(ciskonto1.text,"0");
    String iskonto2=isNull(ciskonto2.text,"0");
    String iskonto3=isNull(ciskonto3.text,"0");
    String iskonto4=isNull(ciskonto4.text,"0");
    String iskonto5=isNull(ciskonto5.text,"0");
    String iskonto6=isNull(ciskonto6.text,"0");

    double tIskonto1=0;
    double tIskonto2=0;
    double tIskonto3=0;
    double tIskonto4=0;
    double tIskonto5=0;
    double tIskonto6=0;
    double toplamIskonto=0;

    switch (iskontono) {
      case 1:        
        iskonto1=iskonto;
        break;
      case 2:        
        iskonto2=iskonto;
        break;
      case 3:        
        iskonto3=iskonto;
        break;
      case 4:        
        iskonto4=iskonto;
        break;
      case 5:        
        iskonto5=iskonto;
        break;
      case 6:        
        iskonto6=iskonto;
        break;
      default:
    }

    tIskonto1=double.parse(setTutar(iskonto1,context));
    tIskonto2=double.parse(setTutar(iskonto2,context));
    tIskonto3=double.parse(setTutar(iskonto3,context));
    tIskonto4=double.parse(setTutar(iskonto4,context));
    tIskonto5=double.parse(setTutar(iskonto5,context));
    tIskonto6=double.parse(setTutar(iskonto6,context));

    if (secilenUrun.indirim01flag==1) toplamIskonto=toplamIskonto + tIskonto1;
    if (secilenUrun.indirim02flag==1) toplamIskonto=toplamIskonto + tIskonto2;
    if (secilenUrun.indirim03flag==1) toplamIskonto=toplamIskonto + tIskonto3;
    if (secilenUrun.indirim04flag==1) toplamIskonto=toplamIskonto + tIskonto4;
    if (secilenUrun.indirim05flag==1) toplamIskonto=toplamIskonto + tIskonto5;
    if (secilenUrun.indirim06flag==1) toplamIskonto=toplamIskonto + tIskonto6;

    if(toplamIskonto>100)
    {
      snackbar("Uyarı", "Toplam İskonto: $toplamIskonto 100 den büyük olamaz!", Icons.person);
      return false;
    }

    return true;
  }

  getSiparis(int siparissayac) async {
    await DBProvider.db.getSiparis(siparissayac);
  }

  Future<int> deleteSiparis(int siparissayac) async {
    return await DBProvider.db.deleteSiparis(siparissayac);
  }

  Future<int> getSiparisSatirCount(int siparissayac) async {
    return await DBProvider.db.getSiparisSatirCount(siparissayac);
  }

  Future<int> getOnaysizSiparisCount(int siparissayac) async {
    return await DBProvider.db.getOnaysizSiparisCount(siparissayac);
  }
  

  siparisOnayla(int siparissayac) async {
    await DBProvider.db.siparisOnayla(siparissayac);
  }

  int kampanyaOtomatik(String satistipi){
    SatisTipi stip;
    if (satisTipleri.where((element) => element.satistipid==satistipi).length>0)
    {
      stip=satisTipleri.firstWhere((element) => element.satistipid==satistipi);
      return stip.kampanyalariotomatikuygula;
    }
    else  return 0;

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
  }

  void getSiparisSatirDegerleri(KampanyaUygulanacaklar item, BuildContext context) {
      
    //secilenUrun=malzemeDetay.firstWhere((element) => element.malzemekodu==item.malzemekodu);
    
    setIskonto(item.iskontotutari1.toString(), 1,context);
    setIskonto(item.iskontotutari2.toString(), 2,context);
    setIskonto(item.iskontotutari3.toString(), 3,context);
    setIskonto(item.iskontotutari4.toString(), 4,context);
    setIskonto(item.iskontotutari5.toString(), 5,context);
    setIskonto(item.iskontotutari6.toString(), 6,context);
    
    cfiyat.text=getTutar(item.birimfiyat.toString(),context);
    cbirim.text=item.bazbirim;
    siparisBirimi.value=item.bazbirim;    
    cmiktar.text=getTutar(item.miktar.toString(),context);
    item.tutar=item.birimfiyat * item.miktar;
    
    ctutar.text=getTutar(item.tutar.toString(),context);
    double indirimlitutar=double.parse(item.tutar.toString()) - double.parse(item.toplamindirim.toString());
    cindirimlitutar.text=getTutar(indirimlitutar.toString(),context);
    ctoplamtutar.text=getTutar(item.satirtutari.toString(),context);
    picture=item.picture;
    tutar.value=double.parse(item.tutar.toString());
    csatiraciklama.text=item.aciklama;
    
    
    kdvTutari.value=double.parse(item.kdvtutari.toString());
    indirimTutari.value=double.parse(item.toplamindirim.toString());
    toplamaTutar.value=double.parse(item.satirtutari.toString());
    sGuid.value=item.guid;
    siparissatirrsayac.value=item.siparissatirrsayac;
    siparissayac.value=item.musrsayac;
    bedelsizptr.value=item.bedelsiztpr;
  
  }

  void getSiparisSatirDegerleriSatirList(SiparisSatirList item, BuildContext context) {

    secilenUrun=malzemeDetay.firstWhere((element) => element.malzemekodu==item.malzemekodu);
    
    setIskonto(item.iskontotutari1.toString(), 1,context);
    setIskonto(item.iskontotutari2.toString(), 2,context);
    setIskonto(item.iskontotutari3.toString(), 3,context);
    setIskonto(item.iskontotutari4.toString(), 4,context);
    setIskonto(item.iskontotutari5.toString(), 5,context);
    setIskonto(item.iskontotutari6.toString(), 6,context);
    
    cfiyat.text=getTutar(item.birimfiyat.toString(),context);
    cbirim.text=item.bazbirim;
    siparisBirimi.value=item.bazbirim;
    
    cmiktar.text=getTutar(item.miktar.toString(),context);
    ctutar.text=getTutar(item.tutar.toString(),context);
    double indirimlitutar=double.parse(item.tutar.toString()) - double.parse(item.toplamindirim.toString());
    cindirimlitutar.text=getTutar(indirimlitutar.toString(),context);
    ctoplamtutar.text=getTutar(item.satirtutari.toString(),context);
    picture=item.picture;
    tutar.value=double.parse(item.tutar.toString());
    csatiraciklama.text=item.aciklama;
    
    
    kdvTutari.value=double.parse(item.kdvtutari.toString());
    indirimTutari.value=double.parse(item.toplamindirim.toString());
    toplamaTutar.value=double.parse(item.satirtutari.toString());
    sGuid.value=item.guid;
    siparissatirrsayac.value=item.siparissatirrsayac;
    siparissayac.value=item.musrsayac;
  }

  Future<List<String>> getSatilacakMiktar(KampanyaUygulanacaklar item) async {
    List<String> list=<String>[];
    for (var i = 0; i < item.bedelsizgruptoplammiktar+1; i++) {
      list.add(i.toString());
    }

    return list;
  }

  List<DropdownMenuItem<String>> getMiktarDropDownMenuItems(KampanyaUygulanacaklar item) {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    
    items.add(new DropdownMenuItem(
      value: "0",
      child: new Text("0"),
      ),
    );

    if (item.bedelsizgruptoplammiktar>0)
    {
      for (var i = 1; i < item.bedelsizgruptoplammiktar+1; i++) {
       items.add(new DropdownMenuItem(
          value: i.toString(),
          child: new Text(i.toString()),
          ),
        );
      }
    }
    
    if (item.satilacakmiktar>0 && item.bedelsizgruptoplammiktar==0 )
    {
      for (var i = 1; i < item.satilacakmiktar+1; i++) {
       items.add(new DropdownMenuItem(
          value: i.toString(),
          child: new Text(i.toString()),
          ),
        );
      }
    }

    return items;
  }

  Future<List<KampanyaUygulanacaklar>> getUygulanacakKampanyalar() async
  {
    return uygulanacakKampanyalar.toList();
  }

  Future<bool> miktarOnChange(KampanyaUygulanacaklar item, int girilenmiktar) async {    
    int kalanMiktar=0;
    double toplamMiktar=0;

    if (item.miktar>0 && girilenmiktar<item.miktar)
    {
      satilacakmiktar.value=item.miktar;
      snackbar("Hata", "Belsiz verilen miktar:${item.miktar} dan küçük olamaz." , Icons.error);
      return false;
    }

    uygulanacakKampanyalar.where((element) => element.grupkodu==item.grupkodu && element.kampanyaRsayac==item.kampanyaRsayac).forEach((uyguItem) {
      if (uyguItem.satilacakmiktar>0 && uyguItem.rowNum!=item.rowNum)
      {
        toplamMiktar=toplamMiktar + uyguItem.satilacakmiktar;
      }
    });

    kalanMiktar=int.parse(
      (item.bedelsizgruptoplammiktar - toplamMiktar).toStringAsFixed(0)
    ) - girilenmiktar;

    if (kalanMiktar<0)
    {
      satilacakmiktar.value=0.0;
      snackbar("Hata", "Belsiz verilen toplam miktar:${item.bedelsizgruptoplammiktar} dan büyük olamaz." , Icons.error);
      return false;
    }

    return true;
  }
  changeSecim(KampanyaUygulanacaklar item, bool value) async {    
    int secim;  
    if (value==true) 
      secim=1; 
    else 
      secim=0;
    if (item.zorunlu==1)
    {
      item.secim=1;
      return;  
    }

    item.secim=secim;
    uygulanacakKampanyalar.forEach((element) { 
      if (element.kampanyaRsayac==item.kampanyaRsayac && element.grupkodu==item.grupkodu)
      { 
        element.secim=secim;        
      }
    });
    
    var rastgeleSayi = Random().nextInt(5000);
    satilacakmiktar.value=double.parse(rastgeleSayi.toString());    
    satilacakmiktar.value=item.satilacakmiktar;
    update();
  }

  Future<List<Ziyaret>> getAllZiyaret() async {
    List<Ziyaret> ziyaretler;
      ziyaretler=await DBProvider.db.getAllZiyaret();

    return ziyaretler;
  }

  Future<List<SiparisIndirim>> getAllSiparisIndirim() async {
    List<SiparisIndirim> siparisIndirimler;
      siparisIndirimler=await DBProvider.db.getAllSiparisIndirim();

    return siparisIndirimler;
  }

  getCariSube() async {    
    final Controller _controller =Get.find();
      cariSubeler=await DBProvider.db.getCariSube(_controller.carikod.value);
      if (cariSubeler.length>0)
      {
        CariSube sube=cariSubeler.first;
        subeadi.value=sube.subeAdi;
        subekodu.value=sube.subeKodu;  
      }
      else
      {
        subeadi.value="";
        subekodu.value="";
      }
      update();
  }

  getCariSubeKodu(String subeAdi) {    
    if (cariSubeler.length>0)
    {
      CariSube sube=cariSubeler.firstWhere((element) => element.subeAdi==subeAdi);
      subekodu.value=sube.subeKodu;
      subeadi.value=sube.subeAdi;
      update();      
    }    
  }

  List<DropdownMenuItem<String>> getCariSubeler() {    
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    if (cariSubeler.length>0)
    {
      cariSubeler.forEach((element) { 
        if (subeadi.value=="")
        {
          subeadi.value=element.subeAdi;
          subekodu.value=element.subeKodu;
        }
        
        items.add(new DropdownMenuItem(
          value: element.subeAdi,
          child: new Text(element.subeAdi)          
          ),
        );
      });
    }

    return items;
  }

  Future<KampanyaYuzdeselSatir> getKampanyaYuzdeselMalzeme(String malzemekodu) async {
    return await DBProvider.db.getKampanyaYuzdeselMalzeme(malzemekodu);
  }

  Future<KampanyaBedelsizSatir> getKampanyaBedelsizMalzeme(String malzemekodu) async {
    return await DBProvider.db.getKampanyaBedelsizMalzeme(malzemekodu);

  }

  




}