
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/controller/rapor_controller.dart';

List<MusteriMalAnalizi> musteriMalAnalizi(String str) =>
    List<MusteriMalAnalizi>.from(
        json.decode(str).map((x) => MusteriMalAnalizi.fromJson(x)));

String musteriMalAnaliziToJson(List<MusteriMalAnalizi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final RaporController _controller = Get.put(RaporController());

class MusteriMalAnalizi {
  String musteriKodu;
  String malzemeKodu;
  String malzemeAdi;
  String birimi;
  String bazBirim;
  String malzemeSinifiNo;
  String malzemeSinifiAdi;
  String grupKodu1;
  String grupKodu2;
  String grupKodu3;
  String grupKodu4;
  String grupKodu5;
  String grupAdi1;
  String grupAdi2;
  String grupAdi3;
  String grupAdi4;
  String grupAdi5;
  String satisTipId;
  String satisTipiAdi;
  String depoNo;
  String depoAdi;
  String raporBirimi;
  double satisMiktari;
  double satisBrutTutar;
  double satisIndirimTutari;
  double satisKdvTutari;
  double satisMasrafTutari;
  double satisKdvOncesiTutar;
  double satisSatirTutari;
  double iadeMiktari;
  double iadeBrutTutar;
  double iadeIndirimTutari;
  double iadeKdvTutari;
  double iadeKdvOncesiTutar;
  double iadeSatirTutari;
  double netMiktar;
  double netBrutTutar;
  double netIndirimTutari;
  double netKdvTutari;
  double netKdvOncesiTutar;
  double netSatirTutari;
  DateTime tarih;
  String grupadi;
  String unvan;
  String grupkodu;

  MusteriMalAnalizi(
      {this.musteriKodu,
      this.malzemeKodu,
      this.malzemeAdi,
      this.birimi,
      this.bazBirim,
      this.malzemeSinifiNo,
      this.malzemeSinifiAdi,
      this.grupKodu1,
      this.grupKodu2,
      this.grupKodu3,
      this.grupKodu4,
      this.grupKodu5,
      this.grupAdi1,
      this.grupAdi2,
      this.grupAdi3,
      this.grupAdi4,
      this.grupAdi5,
      this.satisTipId,
      this.satisTipiAdi,
      this.depoNo,
      this.depoAdi,
      this.raporBirimi,
      this.satisMiktari,
      this.satisBrutTutar,
      this.satisIndirimTutari,
      this.satisKdvTutari,
      this.satisMasrafTutari,
      this.satisKdvOncesiTutar,
      this.satisSatirTutari,
      this.iadeMiktari,
      this.iadeBrutTutar,
      this.iadeIndirimTutari,
      this.iadeKdvTutari,
      this.iadeKdvOncesiTutar,
      this.iadeSatirTutari,
      this.netMiktar,
      this.netBrutTutar,
      this.netIndirimTutari,
      this.netKdvTutari,
      this.netKdvOncesiTutar,
      this.netSatirTutari,
      this.tarih,
      this.grupadi,
      this.unvan,
      this.grupkodu
      });

  MusteriMalAnalizi.fromJson(Map<String, dynamic> json) {
    musteriKodu = json['musteri_kodu'];
    malzemeKodu = json['malzeme_kodu'];
    malzemeAdi = json['malzeme_adi'];
    birimi = json['birimi'];
    bazBirim = json['baz_birim'];
    malzemeSinifiNo = json['malzeme_sinifi_no'];
    malzemeSinifiAdi = json['malzeme_sinifi_adi'];
    grupKodu1 = json['grup_kodu1'];
    grupKodu2 = json['grup_kodu2'];
    grupKodu3 = json['grup_kodu3'];
    grupKodu4 = json['grup_kodu4'];
    grupKodu5 = json['grup_kodu5'];
    grupAdi1 = json['grup_adi1'];
    grupAdi2 = json['grup_adi2'];
    grupAdi3 = json['grup_adi3'];
    grupAdi4 = json['grup_adi4'];
    grupAdi5 = json['grup_adi5'];
    satisTipId = json['satis_tip_id'];
    satisTipiAdi = json['satis_tipi_adi'];
    depoNo = json['depo_no'];
    depoAdi = json['depo_adi'];
    raporBirimi = json['rapor_birimi'];
    satisMiktari = json['satis_miktari'];
    satisBrutTutar = json['satis_brut_tutar'];
    satisIndirimTutari = json['satis_indirim_tutari'];
    satisKdvTutari = json['satis_kdv_tutari'];
    satisMasrafTutari = json['satis_masraf_tutari'];
    satisKdvOncesiTutar = json['satis_kdv_oncesi_tutar'];
    satisSatirTutari = json['satis_satir_tutari'];
    iadeMiktari = json['iade_miktari'];
    iadeBrutTutar = json['iade_brut_tutar'];
    iadeIndirimTutari = json['iade_indirim_tutari'];
    iadeKdvTutari = json['iade_kdv_tutari'];
    iadeKdvOncesiTutar = json['iade_kdv_oncesi_tutar'];
    iadeSatirTutari = json['iade_satir_tutari'];
    netMiktar = json['net_miktar'];
    netBrutTutar = json['net_brut_tutar'];
    netIndirimTutari = json['net_indirim_tutari'];
    netKdvTutari = json['net_kdv_tutari'];
    netKdvOncesiTutar = json['net_kdv_oncesi_tutar'];
    netSatirTutari = json['net_satir_tutari'];
    tarih = json['tarih'] == null ? null : DateTime.parse(json['tarih']);
    unvan = json['unvan'] == null ? null : json['unvan'];
    
    if(_controller.grupkullan.value==0) 
    {
      grupadi= "Malzemeler";
      grupkodu="Malzemeler";
    }
    if(_controller.grupkullan.value==1)
    {
      if (json['grup_adi1']!="" && json['grup_adi1']!=null)      
      {
        grupadi= json['grup_adi1'];
        grupkodu=json['grup_kodu1'];
      }        
      else
      {
        grupadi= "BOŞ";
        grupkodu="BOŞ";
      }
        
    }
      
    if(_controller.grupkullan.value==2) 
    {
      if (json['grup_adi2']!="" && json['grup_adi2']!=null)      
      {
        grupadi= json['grup_adi2'];
        grupkodu=json['grup_kodu2'];
      }      
      else
      {
        grupadi= "BOŞ";
        grupkodu="BOŞ";
      }
    }
      
    if(_controller.grupkullan.value==3) 
    {
      if (json['grup_adi3']!="" && json['grup_adi3']!=null)      
      {
        grupadi= json['grup_adi3'];
        grupkodu=json['grup_kodu3'];
      }            
      else
      {
        grupadi= "BOŞ";
        grupkodu="BOŞ";
      }
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['musteri_kodu'] = this.musteriKodu;
    data['malzeme_kodu'] = this.malzemeKodu;
    data['malzeme_adi'] = this.malzemeAdi;
    data['birimi'] = this.birimi;
    data['baz_birim'] = this.bazBirim;
    data['malzeme_sinifi_no'] = this.malzemeSinifiNo;
    data['malzeme_sinifi_adi'] = this.malzemeSinifiAdi;
    data['grup_kodu1'] = this.grupKodu1;
    data['grup_kodu2'] = this.grupKodu2;
    data['grup_kodu3'] = this.grupKodu3;
    data['grup_kodu4'] = this.grupKodu4;
    data['grup_kodu5'] = this.grupKodu5;
    data['grup_adi1'] = this.grupAdi1;
    data['grup_adi2'] = this.grupAdi2;
    data['grup_adi3'] = this.grupAdi3;
    data['grup_adi4'] = this.grupAdi4;
    data['grup_adi5'] = this.grupAdi5;
    data['satis_tip_id'] = this.satisTipId;
    data['satis_tipi_adi'] = this.satisTipiAdi;
    data['depo_no'] = this.depoNo;
    data['depo_adi'] = this.depoAdi;
    data['rapor_birimi'] = this.raporBirimi;
    data['satis_miktari'] = this.satisMiktari;
    data['satis_brut_tutar'] = this.satisBrutTutar;
    data['satis_indirim_tutari'] = this.satisIndirimTutari;
    data['satis_kdv_tutari'] = this.satisKdvTutari;
    data['satis_masraf_tutari'] = this.satisMasrafTutari;
    data['satis_kdv_oncesi_tutar'] = this.satisKdvOncesiTutar;
    data['satis_satir_tutari'] = this.satisSatirTutari;
    data['iade_miktari'] = this.iadeMiktari;
    data['iade_brut_tutar'] = this.iadeBrutTutar;
    data['iade_indirim_tutari'] = this.iadeIndirimTutari;
    data['iade_kdv_tutari'] = this.iadeKdvTutari;
    data['iade_kdv_oncesi_tutar'] = this.iadeKdvOncesiTutar;
    data['iade_satir_tutari'] = this.iadeSatirTutari;
    data['net_miktar'] = this.netMiktar;
    data['net_brut_tutar'] = this.netBrutTutar;
    data['net_indirim_tutari'] = this.netIndirimTutari;
    data['net_kdv_tutari'] = this.netKdvTutari;
    data['net_kdv_oncesi_tutar'] = this.netKdvOncesiTutar;
    data['net_satir_tutari'] = this.netSatirTutari;
    data['tarih'] = DateFormat('yyyy-MM-dd 00:00:00.000').format(this.tarih);
    return data;
  }
}
