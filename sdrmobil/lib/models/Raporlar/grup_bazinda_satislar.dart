
import 'dart:convert';
import 'package:get/get.dart';
import 'package:sdrmobil/controller/rapor_controller.dart';

List<GrupBazindaSatislarM> grupBazindaSatislarM(String str) =>
    List<GrupBazindaSatislarM>.from(
        json.decode(str).map((x) => GrupBazindaSatislarM.fromJson(x)));

String grupBazindaSatislarMToJson(List<GrupBazindaSatislarM> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final RaporController _controller = Get.put(RaporController());

class GrupBazindaSatislarM {  
  String musterikodu;
  String unvan;  
  String grupAdi1;
  String grupAdi2;
  String grupAdi3;  
  String raporBirimi;  
  double satisMiktari;
  double satisKdvOncesiTutar;
  double iadeMiktari;  
  double iadeKdvOncesiTutar;
  double netMiktar;  
  double netKdvOncesiTutar;  
  String grupadi;
  String grupkodu;

  GrupBazindaSatislarM(
      {
      this.musterikodu,
      this.unvan,
      this.grupAdi1,
      this.grupAdi2,
      this.grupAdi3, 
      this.raporBirimi,
      this.satisMiktari, 
      this.satisKdvOncesiTutar,
      this.iadeMiktari,      
      this.iadeKdvOncesiTutar,
      this.netMiktar,      
      this.netKdvOncesiTutar,      
      this.grupadi,
      this.grupkodu
      });

  GrupBazindaSatislarM.fromJson(Map<String, dynamic> json) {    
    musterikodu = json['musteri_kodu'];
    unvan = json['unvan'];
    grupAdi1 = json['grup_adi1'];
    grupAdi2 = json['grup_adi2'];
    grupAdi3 = json['grup_adi3'];
    raporBirimi = json['rapor_birimi'];
    satisMiktari = json['satis_miktari'];    
    satisKdvOncesiTutar = json['satis_kdv_oncesi_tutar'];
    iadeMiktari = json['iade_miktari'];    
    iadeKdvOncesiTutar = json['iade_kdv_oncesi_tutar'];    
    netMiktar = json['net_miktar'];    
    netKdvOncesiTutar = json['net_kdv_oncesi_tutar'];

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
    data['musteri_kodu'] = this.musterikodu;
    data['unvan'] = this.unvan;
    data['grup_adi1'] = this.grupAdi1;
    data['grup_adi2'] = this.grupAdi2;
    data['grup_adi3'] = this.grupAdi3;
    data['rapor_birimi'] = this.raporBirimi;
    data['satis_miktari'] = this.satisMiktari;
    data['satis_kdv_oncesi_tutar'] = this.satisKdvOncesiTutar;    
    data['iade_miktari'] = this.iadeMiktari;    
    data['iade_kdv_oncesi_tutar'] = this.iadeKdvOncesiTutar;    
    data['net_miktar'] = this.netMiktar;    
    data['net_kdv_oncesi_tutar'] = this.netKdvOncesiTutar;

    return data;
  }
}
