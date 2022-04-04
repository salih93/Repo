import 'dart:convert';

List<SiparisIndirim> siparisIndirimFromJson(String str) =>
    List<SiparisIndirim>.from(
        json.decode(str).map((x) => SiparisIndirim.fromJson(x)));

String siparisIndirimToJson(List<SiparisIndirim> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SiparisIndirim {
  int	rsayac;
  int	siparissatirrsayac;
  String indirimkodu;
  double indirimyuzdesi;
  int	siparisrsayac;
  int	sirano;
  double indirimtutari;
  String vadesablon;
  String indirimtipi;
  double satilan;
  int	rtrg;
  double indirim01;
  double indirim02;
  double indirim03;
  double indirim04;
  double indirim05;
  double indirim06;
  String grupkodu;

 SiparisIndirim(
  {
    this.rsayac,
    this.siparissatirrsayac,
    this.indirimkodu,
    this.indirimyuzdesi,
    this.siparisrsayac,
    this.sirano,
    this.indirimtutari,
    this.vadesablon,
    this.indirimtipi,
    this.satilan,
    this.rtrg,
    this.indirim01,
    this.indirim02,
    this.indirim03,
    this.indirim04,
    this.indirim05,
    this.indirim06,
    this.grupkodu
  });

  SiparisIndirim.fromJson(Map<String, dynamic> json) {    
    rsayac=json['r_sayac'];
    siparissatirrsayac=json['siparis_satir_rsayac'];
    indirimkodu=json['indirim_kodu'];
    indirimyuzdesi=json['indirim_yuzdesi'];
    siparisrsayac=json['siparis_rsayac'];
    sirano=json['sira_no'];
    indirimtutari=json['indirim_tutari'];
    vadesablon=json['vade_sablon'];
    indirimtipi=json['indirim_tipi'];
    satilan=json['satilan'];
    rtrg=json['r_trg'];
    indirim01=json['indirim01'];
    indirim02=json['indirim02'];
    indirim03=json['indirim03'];
    indirim04=json['indirim04'];
    indirim05=json['indirim05'];
    indirim06=json['indirim06'];
    grupkodu=json['grup_kodu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siparis_satir_rsayac']=this.siparissatirrsayac;
    data['indirim_kodu']=this.indirimkodu;
    data['indirim_yuzdesi']=this.indirimyuzdesi;
    data['siparis_rsayac']=this.siparisrsayac;
    data['sira_no']=this.sirano;
    data['indirim_tutari']=this.indirimtutari;
    data['vade_sablon']=this.vadesablon;
    data['indirim_tipi']=this.indirimtipi;
    data['satilan']=this.satilan;
    data['r_trg']=this.rtrg;
    data['indirim01']=this.indirim01;
    data['indirim02']=this.indirim02;
    data['indirim03']=this.indirim03;
    data['indirim04']=this.indirim04;
    data['indirim05']=this.indirim05;
    data['indirim06']=this.indirim06;
    data['grup_kodu']=this.grupkodu;    
    
    return data;
  }

  

}