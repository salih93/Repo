import 'dart:convert';

List<SiparisSatirGruplu> siparisSatirGrupluFromJson(String str) =>
    List<SiparisSatirGruplu>.from(
        json.decode(str).map((x) => SiparisSatirGruplu.fromJson(x)));

String siparisSatirGrupluToJson(List<SiparisSatirGruplu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SiparisSatirGruplu {
  String malzemekodu;
  String birimi;  
  double miktar;
  int kampanyaRsayac;
  String kampanyaadi;
  String grupAdi;

 SiparisSatirGruplu(
  {
    this.malzemekodu,    
    this.birimi,
    this.miktar,
    this.kampanyaRsayac,
    this.kampanyaadi,
    this.grupAdi
  });

  SiparisSatirGruplu.fromJson(Map<String, dynamic> json) {    
    malzemekodu=json['malzeme_kodu'];   
    birimi=json['birimi'];
    miktar=json['miktar'];
    kampanyaRsayac=json['kampanya_rsayac'];
    kampanyaadi=json['kampanya_adi'];
    grupAdi=json['grup_adi'] == null ? "" : json['grup_adi']; 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['malzeme_kodu']=malzemekodu;
    data['birimi']=birimi;
    data['miktar']=miktar;
    data['kampanya_rsayac']=kampanyaRsayac;
    data['kampanya_adi']=kampanyaadi;
    return data;
  }

  

}