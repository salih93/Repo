import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';

List<MalzemeFiyat> malzemeFiyatFromJson(String str) =>
    List<MalzemeFiyat>.from(
        json.decode(str).map((x) => MalzemeFiyat.fromJson(x)));

String malzemeFiyatToJson(List<MalzemeFiyat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final SiparisController _controller = Get.put(SiparisController());

class MalzemeFiyat {
  String malzemekodu;
  String malzemeadi;
  String grupadi1;
  String grupadi2;
  String grupadi3;
  String path;
  double birimfiyat;
  int	indirim01flag;
  int	indirim02flag;
  int	indirim03flag;
  int	indirim04flag;
  int	indirim05flag;
  int	indirim06flag;
  double iskontotutari1;
  double iskontotutari2;
  double iskontotutari3;
  double iskontotutari4;
  double iskontotutari5;
  double iskontotutari6;
  String vadekodu;
  double kdvorani;
  String grupadi;
  String bazbirim;
  Uint8List picture;
  int rowNum;
  String barkod;
  double stokmiktari;
  int siparissatirrsayac;
  int ciftkayit;
  double yuzdeselindirim=0;
  String bedelsizGrupAdi="";
  

 MalzemeFiyat(
      {
        this.malzemekodu,
        this.malzemeadi,
        this.grupadi1,
        this.grupadi2,
        this.grupadi3,
        this.path,
        this.birimfiyat,
        this.indirim01flag,
        this.indirim02flag,
        this.indirim03flag,
        this.indirim04flag,
        this.indirim05flag,
        this.indirim06flag,
        this.iskontotutari1,
        this.iskontotutari2,
        this.iskontotutari3,
        this.iskontotutari4,
        this.iskontotutari5,
        this.iskontotutari6,
        this.vadekodu,
        this.kdvorani,
        this.grupadi,
        this.bazbirim,
        this.picture,
        this.rowNum,
        this.barkod,
        this.stokmiktari,
        this.siparissatirrsayac,
        this.ciftkayit,
        this.yuzdeselindirim,
        this.bedelsizGrupAdi        
      });

  MalzemeFiyat.fromJson(Map<String, dynamic> json) {    
    malzemekodu=json['malzeme_kodu'];
    malzemeadi=json['malzeme_adi'];
    grupadi1=json['grup_adi1'];
    grupadi2=json['grup_adi2'];
    grupadi3=json['grup_adi3'];
    path=json['path'];
    birimfiyat=json['birim_fiyat'];
    indirim01flag=json['indirim01_flag'];
    indirim02flag=json['indirim02_flag'];
    indirim03flag=json['indirim03_flag'];
    indirim04flag=json['indirim04_flag'];
    indirim05flag=json['indirim05_flag'];
    indirim06flag=json['indirim06_flag'];
    iskontotutari1=json['iskonto_tutari1'];
    iskontotutari2=json['iskonto_tutari2'];
    iskontotutari3=json['iskonto_tutari3'];
    iskontotutari4=json['iskonto_tutari4'];
    iskontotutari5=json['iskonto_tutari5'];
    iskontotutari6=json['iskonto_tutari6'];   
    vadekodu=json['vade_kodu'];    
    kdvorani=json['kdv_orani'];
    bazbirim=json['baz_birim'];
    picture=json['picture'];
    rowNum=json['rowNum'];
    barkod=json['barkod'];
    stokmiktari=json['stok_miktari'];
    siparissatirrsayac=json['siparis_satir_rsayac']==null ? 0:json['siparis_satir_rsayac'];
    ciftkayit=json['cift_kayit']==null ? 0:json['cift_kayit'];
    
    if(_controller.grupkullan.value==0) 
      grupadi= "Malzemeler";

    if(_controller.grupkullan.value==1)
    {
      if (json['grup_adi1']!="" && json['grup_adi1']!=null)      
        grupadi= json['grup_adi1'];      
      else
        grupadi= "BOŞ";
    }
      
    if(_controller.grupkullan.value==2) 
    {
      if (json['grup_adi2']!="" && json['grup_adi2']!=null)      
        grupadi= json['grup_adi2'];      
      else
        grupadi= "BOŞ";
    }
      
    if(_controller.grupkullan.value==3) 
    {
      if (json['grup_adi3']!="" && json['grup_adi3']!=null)      
        grupadi= json['grup_adi3'];      
      else
        grupadi= "BOŞ";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['malzeme_kodu']=malzemekodu;
    data['malzeme_adi']=malzemeadi;
    data['grup_adi1']=grupadi1;
    data['grup_adi2']=grupadi2;
    data['grup_adi3']=grupadi3;
    data['path']=path;
    data['birim_fiyat']=birimfiyat;
    data['indirim01_flag']=indirim01flag;
    data['indirim02_flag']=indirim02flag;
    data['indirim03_flag']=indirim03flag;
    data['indirim04_flag']=indirim04flag;
    data['indirim05_flag']=indirim05flag;
    data['indirim06_flag']=indirim06flag;
    data['iskonto_tutari1']=iskontotutari1;
    data['iskonto_tutari2']=iskontotutari2;
    data['iskonto_tutari3']=iskontotutari3;
    data['iskonto_tutari4']=iskontotutari4;
    data['iskonto_tutari5']=iskontotutari5;
    data['iskonto_tutari6']=iskontotutari6;   
    data['vade_kodu']=vadekodu;
    data['kdv_orani']=kdvorani;
    data['baz_birim']=bazbirim;
    data['picture']=picture;
    data['barkod']=barkod;
    data['stok_miktari']=stokmiktari;
        
    return data;
  }

  

}





  
  


  
