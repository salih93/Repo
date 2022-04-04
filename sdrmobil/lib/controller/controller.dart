import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/VeritabaniIslemleri/cari_veri_islemleri.dart';
import 'package:sdrmobil/VeritabaniIslemleri/ziyaret_veri_islemleri.dart';
import 'package:sdrmobil/components/progress_bar_percent.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Satis/aylik_satis.dart';
import 'package:sdrmobil/models/Cari/cari_hesap_ekstresi.dart';
import 'package:sdrmobil/models/Cari/cari_hesap_ekstresi_toplam.dart';
import 'package:sdrmobil/models/Cari/cari_rut.dart';
import 'package:sdrmobil/models/Cari/cari_vade_farki.dart';
import 'package:sdrmobil/models/Satis/rut_listesi.dart';
import 'package:sdrmobil/models/Tahsilat/tahsilat_sayisi.dart';
import 'package:sdrmobil/models/tanimlar.dart';
import 'package:sdrmobil/providers/db_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class YeniListe {
  final String gun;
  final int noktasayisi;
  final int bugun;
  List<RutListesi> children = [];  

  YeniListe(this.gun, this.noktasayisi, this.children, this.bugun);
}

class Gunler {
  final String gun;  
  final int bugun;

  Gunler(this.gun, this.bugun);
}


class Controller extends GetxController {
  var token = "".obs;
  var userid="".obs;
  var firmaid="".obs;  
  var firmaadi="".obs;
  var firmaurl="".obs;
  var veritabaniadi="".obs;
  var temsilcikodu="".obs;
  var temsilciadi="".obs;
  var hata="".obs;
  var zyrtSearch="".obs;
  var carikod = "".obs;    
  var menuGoruntule=0.obs;  
  var pass="".obs;
  var email="".obs;
  var carifilter="".obs;

  RxInt uzaksiparis=0.obs;
  RxInt musteriKarti=0.obs;
  RxInt ziyarettipisayac=0.obs;
  RxInt ziyaretsonlandirmatipisayac=0.obs;
  RxInt rutaGore=0.obs;

  RxInt tahsilat=0.obs;
  RxInt siparisSayisi=0.obs;
  RxInt fatura=0.obs;
  RxInt rutici=0.obs;
  RxInt rutdisi=0.obs;  
  RxInt rutdetaysayac=0.obs;
  RxInt rutdetaygun=0.obs;
  RxInt aktarilmamisZiyaret=0.obs;

  RxInt fiyatkilidi=0.obs;
  RxInt iskontokilidi=0.obs;
  RxInt sicaksatiskullansin=0.obs;
  RxInt nakittahsilatkullansin=0.obs;
  RxInt deleteDatabase=0.obs;
  RxInt veritabaniSilindi=0.obs;
  RxInt uzakIslemziyaretId=0.obs;
  RxInt yuzdeselKampanya=0.obs;
  RxInt bedelsizKampanya=0.obs;
  RxInt telefonSiparis=0.obs;
  RxInt kampanyaSecili=0.obs;
  RxInt birimFiyatRakamSayisi=0.obs;
  RxInt siparisOnayliyaDussun=0.obs;
  RxInt sifirStokGosterme=0.obs;
  
  RxDouble faturatoplam=0.0.obs;
  RxDouble siparistoplam=0.0.obs;
  RxDouble tahsilattoplam=0.0.obs;

  RxDouble yuzdeOndalik=0.1.obs;
  RxString yuzdeYuzuzerinden="".obs;
  RxString mesafe="".obs;
  RxString searchValueSatis="".obs;
  RxString aktarimDurumu="".obs;
    
  RxBool startTimer=false.obs;
  List<Tanimlar> tanimList=<Tanimlar>[].obs;
  RxBool isSearching = false.obs;
  RxBool isSearchingSatis = false.obs;
  RxBool isMethod=false.obs;  
  RxBool tutarFocus=false.obs;
  RxInt siparisTahsilatSayisi=0.obs;

  List<CariRut> rutmaster=<CariRut>[];
  List<RutListesi> rutdetay=<RutListesi>[];
  List<YeniListe> data = <YeniListe>[];
  List<YeniListe> filteredList = <YeniListe>[];
  List<CariHesapEkstresi> cariHE=<CariHesapEkstresi>[];  
  
  Rx<RutListesi> rut=new RutListesi().obs;
  RxInt hataNumber=0.obs;

  RxDouble enlem=0.0.obs;
  RxDouble boylam=0.0.obs;

  RxDouble currentlatitude=0.0.obs;
  RxDouble currentlongitude=0.0.obs;  
  RxInt ziyaretId=0.obs;
    
  final FocusNode focusNode=FocusNode();
  final FocusNode mkfocusNode=FocusNode();  

  final boxStorage = GetStorage().obs;
  final TextEditingController emailController = new TextEditingController();  
  final TextEditingController eskiPasswordController = new TextEditingController();
  final TextEditingController yeniPasswordController = new TextEditingController();
  final TextEditingController yeniPasswordTekrarController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController veritabaniGuncelle = new TextEditingController();
  

  @override
  void onInit() {
    if (boxStorage.value.read('beniHatirla')==1)
    {
      changeBeniHatirla();
      emailController.text=boxStorage.value.read("email").toString();      
      passwordController.text=boxStorage.value.read("password");      
    }
    else
    {      
      if (boxStorage.value.read("email")!=null)      
        emailController.text=boxStorage.value.read("email").toString();
      else
        emailController.text="";        
      passwordController.text="";      
    }
    
    super.onInit();
  }  

  @override
  void onClose() {            
    super.onClose();  
  }
  
  RxBool isLoading=false.obs;
  RxBool isAktarimlar=false.obs;
  RxBool beniHatirla = false.obs;

  void setLoading(bool value) {    
    isLoading.value=value;
    update();
  }

  void setZiyaretId(int value) {
    ziyaretId.value=value;
    update();
  }

  void setUzakIslemZiyaretId(int value) {
    uzakIslemziyaretId.value=value;
    update();
  }

  bool getLoading() {        
    return isLoading.value;
  }

  changeBeniHatirla() {
    if(beniHatirla.isTrue){
      beniHatirla.value = false;
    }
    else {
      beniHatirla.value = true; //or pressedBool.toggle();      
    }
    update();   
  }

  bool getBeniHatirla(){
    return beniHatirla.value;
  }

    
  getTanimlar() async {
    List<Tanimlar> listTanim;

    listTanim= await DBProvider.db.getAllTanimlar();
    listTanim.forEach((element) { 
      tanimList.add(element);

      if (element.key=="fiyat_kilidi")
        fiyatkilidi.value=int.parse(element.value);

      if (element.key=="iskonto_kilidi")
        iskontokilidi.value=int.parse(element.value);

      if (element.key=="sicak_satis_kullan")
      {
        sicaksatiskullansin.value=0;
        if (int.parse(element.value)==1)
        {
          if (element.key=="sicak_satis_kullansin")
            sicaksatiskullansin.value=int.parse(element.value);
        }
      }
      if (element.key=="nakit_tahsilat_kullansin")
        nakittahsilatkullansin.value=int.parse(element.value);

      if (element.key=="ruta_gore")
        rutaGore.value=int.parse(element.value);

      if (element.key=="yuzdesel_kampanya_kullan")
        yuzdeselKampanya.value=int.parse(element.value);

      if (element.key=="bedelsiz_kampanya")
        bedelsizKampanya.value=int.parse(element.value);

      if (element.key=="telefon_siparis")
        telefonSiparis.value=int.parse(element.value);

      if (element.key=="kampanya_secili")
        kampanyaSecili.value=int.parse(element.value);

      if (element.key=="birim_fiyat_rakam_sayisi")
        birimFiyatRakamSayisi.value=int.parse(element.value);

      if (element.key=="siparis_onay")
        siparisOnayliyaDussun.value=int.parse(element.value);

      if (element.key=="sifir_stok_gosterme")
        sifirStokGosterme.value=int.parse(element.value);
      
    });
    
    update();    
  }

  getToplamTahsilat() async {
    TahsilatSayisi tahsilatSayisi;    
    tahsilatSayisi = await DBProvider.db.getToplamTahsilat();
    tahsilat.value = tahsilatSayisi.tahsilat;
    rutici.value = tahsilatSayisi.rutici;
    rutdisi.value = tahsilatSayisi.rutdisi;
    if (tahsilatSayisi.aktarimtarihi!=null)
      aktarimDurumu.value=DateFormat('yyyy-MM-dd HH:mm:ss').format(tahsilatSayisi.aktarimtarihi);
    else
      aktarimDurumu.value="Henüz Aktarım yapılmamış.";

    update();    
  }

  getAllSiparisCount() async {    
    int kayitSayisi = await DBProvider.db.getAllSiparisCount();
    siparisSayisi.value=kayitSayisi;

    update();
  }


 Future<List<CariHesapEkstresi>> getCariHesapEkstresi() async {    
     return await DBProvider.db.getCariHesapEkstresi();
          
  }
  Future<List<CariHesapEkstresiToplam>> getCariHesapEkstresiToplam() async {    
     return await DBProvider.db.getCariHesapEkstresiToplam();
          
  }

  Future<List<CariAylikSatis>> getCariSatislar() async {    
    List<CariAylikSatis> cariSatis=await DBProvider.db.getCariSatislar();
    return cariSatis;
  }

  Future<List<CariAylikSatis>> getCariAylikSatis(String malzemekodu) async {
    List<CariAylikSatis> cariAS;
    cariAS=await DBProvider.db.getCariAylikSatis(malzemekodu);
    return cariAS;
  }  

  Future<List<CariVadeFarki>> getCariVadeFarki() async {
    List<CariVadeFarki> cariVF;
    cariVF=await DBProvider.db.getCariVadeFarki();
    return cariVF;
  }

 

  Future<List<YeniListe>> dataDoldur() async {
    rutmaster = await DBProvider.db.getRutGunler();
    rutdetay = await DBProvider.db.getGunRutListesi();   

    data = <YeniListe>[].obs;
    rutmaster.forEach((gunler) {
      bool ekle=true;        
      if (rutaGore.value==1 && gunler.bugun!=1) ekle=false;
      if (ekle)
      {
        data.add(
          YeniListe(gunler.gun, gunler.aktifnoktasayisi, filter(gunler.gun), gunler.bugun)
        );
      }

    });
    
    return data;    
  }

  Future<List<CariAylikSatis>> getfilterSatislar() async {      
      List<CariAylikSatis> cariSatisfiltered=await DBProvider.db.getCariSatislar();
      
      return cariSatisfiltered
          .where((item)=>
            (item.malzemeKodu.toLowerCase().contains(searchValueSatis.value.toLowerCase()) ||
            item.malzemeAdi.toLowerCase().contains(searchValueSatis.value.toLowerCase()))
          ).toList();
  }

  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;    


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {      
        await Geolocator.openLocationSettings();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {    
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {    
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    }

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((Position position) async {        
      currentlatitude.value=position.latitude;
      currentlongitude.value=position.longitude;})
      .catchError((e) {
        print(e);
      });
  }

  siparisTahsilatControl() async
  {
    int kayitSayisi=0;
    kayitSayisi =await DBProvider.db.getAllSiparisCount();
    kayitSayisi = kayitSayisi + await DBProvider.db.getTahsilatCount();

    siparisTahsilatSayisi.value=kayitSayisi;
    update();
  }

  void startProgress(){
    yuzdeOndalik.value =0;
    yuzdeYuzuzerinden.value ="0.0%";

    Get.to(()=>ProgressPercentIndicator());
    startTimer.value = true;
  }

    getAktarilmamisZiyaret() async
    {
      aktarilmamisZiyaret.value=await DBProvider.db.getAktarilmamisZiyaret();
    }
    
    stopProgress(BuildContext context) {
      if (startTimer.value)
      {   
          startTimer.value=false;
          Navigator.of(context).pop();                 
      }
    }

    List<RutListesi> filter(String gun) {
      return rutdetay.where((element) => element.gun == gun).toList();
    }

  Future<List<YeniListe>> filterCari(value) async {      
      List<RutListesi> temp = rutdetay
          .where((element) =>
              element.unvan.toLowerCase().contains(value.toLowerCase()))
          .toList();
      filteredList = <YeniListe>[].obs;

      List<Gunler> gunler = <Gunler>[];

      temp.forEach((element) {
        if (gunler.where((b) => b.gun==element.gun).length==0) {
          var d=rutmaster.where((a) => a.gun==element.gun).first;          
          gunler.add(new Gunler(element.gun, d.bugun));
        }
      });

      for (var item in gunler) {
        bool ekle=true;        
        if (rutaGore.value==1 && item.bugun!=1) ekle=false;
        if (ekle)
        {
          await Future.delayed(Duration(milliseconds: 1), 
            () => filteredList.add(          
              YeniListe(item.toString(), gunler.length,
                temp.where((element) => element.gun == item.toString()).toList(), item.bugun)
            )
          );
        }
      }
      

    return filteredList;    
  }

  bekleyenSiparisGruplu() async {
    final SiparisController _controller = Get.find();
    await _controller.bekleyenSiparisGruplu();
  }
  
  Future<bool> girisIslemleri(String cariKod) async {
    final SiparisController _controller = Get.find();

    carikod.value = cariKod;
    update();    

    if (await CariVeriIslemleri().loadFromApiCari()!=true)
    {
      return false;
    }
    if (await ZiyaretVeriIslemleri().ziyaretBaslat()!=true)
    {      
      return false;    
    }

    _controller.data.clear();
    await _controller.malzemeDoldur(0);
    return true;
  }

}




