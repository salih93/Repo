
import 'dart:convert';

List<MusteriMalAnaliziMlzMusToplam> musteriMalAnaliziMlzMusToplam(String str) =>
    List<MusteriMalAnaliziMlzMusToplam>.from(
        json.decode(str).map((x) => MusteriMalAnaliziMlzMusToplam.fromJson(x)));

String musteriMalAnaliziMlzMusToplamToJson(List<MusteriMalAnaliziMlzMusToplam> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class MusteriMalAnaliziMlzMusToplam {  
  String malzemeKodu;
  String malzemeAdi;
  String musteriKodu;
  String unvan;
  String raporBirimi;  
  double satisMiktari;
  double satisKdvOncesiTutar;
  double iadeMiktari;  
  double iadeKdvOncesiTutar;
  double netMiktar;  
  double netKdvOncesiTutar;  
  String grupkodu1;
  String grupkodu2;
  String grupkodu3;

  MusteriMalAnaliziMlzMusToplam(
      {
      this.malzemeKodu,
      this.malzemeAdi,
      this.musteriKodu,      
      this.raporBirimi,
      this.satisMiktari, 
      this.satisKdvOncesiTutar,
      this.iadeMiktari,      
      this.iadeKdvOncesiTutar,
      this.netMiktar,      
      this.netKdvOncesiTutar,      
      this.grupkodu1,
      this.grupkodu2,
      this.grupkodu3,
      this.unvan
      });

  MusteriMalAnaliziMlzMusToplam.fromJson(Map<String, dynamic> json) {    
    malzemeKodu = json['malzeme_kodu'];
    malzemeAdi = json['malzeme_adi'];
    musteriKodu = json['musteri_kodu'];    
    raporBirimi = json['rapor_birimi'];
    satisMiktari = json['satis_miktari'];    
    satisKdvOncesiTutar = json['satis_kdv_oncesi_tutar'];
    iadeMiktari = json['iade_miktari'];    
    iadeKdvOncesiTutar = json['iade_kdv_oncesi_tutar'];    
    netMiktar = json['net_miktar'];    
    netKdvOncesiTutar = json['net_kdv_oncesi_tutar'];
    grupkodu1 = json['grup_kodu1'];
    grupkodu2 = json['grup_kodu2'];
    grupkodu1 = json['grup_kodu3'];
    unvan = json['unvan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();    
    data['malzeme_kodu'] = this.malzemeKodu;
    data['malzeme_adi'] = this.malzemeAdi;
    data['musteri_kodu']= this.musteriKodu;    
    data['grup_kodu1'] = this.grupkodu1;
    data['grup_kodu2'] = this.grupkodu2;
    data['grup_kodu3'] = this.grupkodu3;
    data['rapor_birimi'] = this.raporBirimi;
    data['satis_miktari'] = this.satisMiktari;
    data['satis_kdv_oncesi_tutar'] = this.satisKdvOncesiTutar;    
    data['iade_miktari'] = this.iadeMiktari;    
    data['iade_kdv_oncesi_tutar'] = this.iadeKdvOncesiTutar;    
    data['net_miktar'] = this.netMiktar;    
    data['net_kdv_oncesi_tutar'] = this.netKdvOncesiTutar;
    data['unvan']=this.unvan;

    return data;
  }
}
