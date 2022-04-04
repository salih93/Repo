import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/controller/controller.dart';


List<Siparis> siparisFromJson(String str) =>
    List<Siparis>.from(
        json.decode(str).map((x) => Siparis.fromJson(x)));

String siparisToJson(List<Siparis> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson(0))));
final Controller _controller =Get.find();

class Siparis {
  int rsayac;
  String cid;  
  String musterino;
  String teslimmusterino;  
  DateTime siparistarihi;
  String siparisasama;
  String satistipi;
  int siparisno;
  String parabirimi;
  String satistemsilcisi;
  double siparistutari;
  double toplamtutar;
  double indirimtutari;
  int onay;
  double toplamkdv;
  int sonversiyon;
  double toplamotv;
  String subfaturatipiid;
  String tesisno;
  String depono;
  String siparisfirma;
  String aktarimtipi;
  String kullanici;
  String stoktipino;  
  DateTime sevktarihi;  
  int returnsayac;
  String subekodu;
  String adrestanimikod2;
  String adrestanimi;  
  int androidgpssayac;
  String aciklama;
  String siparisformaciklama;
  String aciklamaandroid;
  String guid;
  String satistipiadi;
  double toplammiktar;
  int uruncesidi;
  String unvan;

 Siparis(
      {      
      this.rsayac,
      this.cid,
      this.musterino,
      this.teslimmusterino,
      this.siparistarihi,
      this.siparisasama,
      this.satistipi,
      this.siparisno,
      this.parabirimi,
      this.satistemsilcisi,
      this.siparistutari,
      this.toplamtutar,
      this.indirimtutari,
      this.onay,
      this.toplamkdv,
      this.sonversiyon,
      this.toplamotv,
      this.subfaturatipiid,
      this.tesisno,
      this.depono,
      this.siparisfirma,
      this.aktarimtipi,
      this.kullanici,
      this.stoktipino,
      this.sevktarihi,
      this.returnsayac,
      this.subekodu,
      this.adrestanimikod2,
      this.adrestanimi,
      this.androidgpssayac,
      this.aciklama,
      this.siparisformaciklama,
      this.aciklamaandroid,
      this.guid,
      this.satistipiadi,
      this.toplammiktar,
      this.uruncesidi,
      this.unvan     
    });

  Siparis.fromJson(Map<String, dynamic> json) {
        
    rsayac=json['r_sayac'];
    cid=json['cid'];
    musterino=json['musteri_no'];
    teslimmusterino=json['teslim_musteri_no'];
    siparistarihi=json['siparis_tarihi'] == null ? null : DateTime.parse(json['siparis_tarihi']);
    siparisasama=json['siparis_asama'];
    satistipi= json['satis_tipi'];    
    siparisno=json['siparis_no'];
    parabirimi=json['para_birimi'];
    satistemsilcisi=json['satis_temsilcisi'];
    siparistutari=json['siparis_tutari']==null ? 0 : json['siparis_tutari'];
    toplamtutar=json['toplam_tutar']==null ? 0: json['toplam_tutar'];
    indirimtutari=json['indirim_tutari']==null ? 0:json['indirim_tutari'];
    onay=(_controller.isAktarimlar.value==true && _controller.siparisOnayliyaDussun.value==0) ? 0:json['onay'];
    toplamkdv=json['toplam_kdv']==null ? 0:json['toplam_kdv'];
    sonversiyon=json['son_versiyon'];
    toplamotv=json['toplam_otv'];
    subfaturatipiid=json['sub_fatura_tipi_id'];
    tesisno=json['tesis_no'];
    depono=json['depo_no'];
    siparisfirma=json['siparis_firma'];
    aktarimtipi=json['aktarim_tipi'];
    kullanici=json['kullanici'];
    stoktipino=json['stok_tipi_no'];
    sevktarihi=json['sevk_tarihi'] == null ? null : DateTime.parse(json['sevk_tarihi']);
    returnsayac=json['return_sayac'];
    subekodu=json['sube_kodu'];
    adrestanimikod2=json['adres_tanimi_kod2'];
    adrestanimi=json['adres_tanimi'];
    androidgpssayac=json['android_gps_sayac'];
    aciklama=json['aciklama'];
    siparisformaciklama=json['siparis_form_aciklama'];
    aciklamaandroid=json['aciklama_android'];
    guid=json['guid'];
    satistipiadi=json['satis_tipi_adi'];
    toplammiktar=json['toplam_miktar']==null ? 0:json['toplam_miktar'];
    uruncesidi=json['urun_cesidi'];
    unvan=json['unvan'] == null ? "" : json['unvan'];
  }
      
  //data['tarih'] = DateFormat('yyyy-MM-dd 00:00:00.000').format(this.tarih);

  Map<String, dynamic> toJson(int sayacvar) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (sayacvar==1) data['r_sayac'] = this.rsayac;

    data['cid']=this.cid;
    data['musteri_no']=this.musterino;
    data['teslim_musteri_no']=this.teslimmusterino;
    data['siparis_tarihi']=DateFormat('yyyy-MM-dd 00:00:00.000').format(this.siparistarihi);
    data['siparis_asama']=this.siparisasama;
    data['satis_tipi']=this.satistipi;
    data['siparis_no']=this.siparisno;
    data['para_birimi']=this.parabirimi;
    data['satis_temsilcisi']=this.satistemsilcisi;
    data['siparis_tutari']=this.siparistutari;
    data['toplam_tutar']=this.toplamtutar;
    data['indirim_tutari']=this.indirimtutari;
    data['onay']=this.onay;
    data['toplam_kdv']=this.toplamkdv;
    data['son_versiyon']=this.sonversiyon;
    data['toplam_otv']=this.toplamotv;
    data['sub_fatura_tipi_id']=this.subfaturatipiid;
    data['tesis_no']=this.tesisno;
    data['depo_no']=this.depono;
    data['siparis_firma']=this.siparisfirma;
    data['aktarim_tipi']=this.aktarimtipi;
    data['kullanici']=this.kullanici;
    data['stok_tipi_no']=this.stoktipino;
    data['sevk_tarihi']=DateFormat('yyyy-MM-dd 00:00:00.000').format(this.sevktarihi);
    data['return_sayac']=this.returnsayac;
    data['sube_kodu']=this.subekodu;
    data['adres_tanimi_kod2']=this.adrestanimikod2;
    data['adres_tanimi']=this.adrestanimi;
    data['android_gps_sayac']=this.androidgpssayac;
    data['aciklama']=this.aciklama;
    data['siparis_form_aciklama']=this.siparisformaciklama;
    data['aciklama_android']=this.aciklamaandroid;
    data['guid']=this.guid;

    return data;
  }

  Map<String, dynamic> toJsonUpdate() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['cid']=this.cid;
    data['musteri_no']=this.musterino;
    data['teslim_musteri_no']=this.teslimmusterino;
    data['siparis_tarihi']=DateFormat('yyyy-MM-dd 00:00:00.000').format(this.siparistarihi);
    data['siparis_asama']=this.siparisasama;
    data['satis_tipi']=this.satistipi;
    data['siparis_no']=this.siparisno;
    data['para_birimi']=this.parabirimi;
    data['satis_temsilcisi']=this.satistemsilcisi;
    data['siparis_tutari']=this.siparistutari;
    data['toplam_tutar']=this.toplamtutar;
    data['indirim_tutari']=this.indirimtutari;
    data['onay']=this.onay;
    data['toplam_kdv']=this.toplamkdv;
    data['son_versiyon']=this.sonversiyon;
    data['toplam_otv']=this.toplamotv;
    data['sub_fatura_tipi_id']=this.subfaturatipiid;
    data['tesis_no']=this.tesisno;
    data['depo_no']=this.depono;
    data['siparis_firma']=this.siparisfirma;
    data['aktarim_tipi']=this.aktarimtipi;
    data['kullanici']=this.kullanici;
    data['stok_tipi_no']=this.stoktipino;
    data['sevk_tarihi']=DateFormat('yyyy-MM-dd 00:00:00.000').format(this.sevktarihi);
    data['return_sayac']=this.returnsayac;
    data['sube_kodu']=this.subekodu;
    data['adres_tanimi_kod2']=this.adrestanimikod2;
    data['adres_tanimi']=this.adrestanimi;
    data['android_gps_sayac']=this.androidgpssayac;
    data['aciklama']=this.aciklama;
    data['siparis_form_aciklama']=this.siparisformaciklama;
    data['aciklama_android']=this.aciklamaandroid;
    data['guid']=this.guid;

    return data;
  }

}
