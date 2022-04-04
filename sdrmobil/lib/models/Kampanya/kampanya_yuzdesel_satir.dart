class KampanyaYuzdeselSatir {
  int rSayac;
  int kampanyaRsayac;
  String malzemeSinifi;
  String malzemeKodu;
  double yuzde;
  double kota;
  String birim;
  double miktarSarti;
  int noktaUygulama;
  String cid;
  double satisFiyati;
  double maxYuzde;
  String grupKodu;
  double indirim01;
  double indirim02;
  double indirim03;
  double indirim04;
  double indirim05;
  double indirim06;
  double maxmiktar;
  double minmiktar;
  int iskontohanesi;
  String kampanyaadi;  
  String grupAdi;
  String kampanyakodu;
  int zorunlu;

  KampanyaYuzdeselSatir(
      {this.rSayac,
      this.kampanyaRsayac,
      this.malzemeSinifi,
      this.malzemeKodu,
      this.yuzde,
      this.kota,
      this.birim,
      this.miktarSarti,
      this.noktaUygulama,
      this.cid,
      this.satisFiyati,
      this.maxYuzde,
      this.grupKodu,
      this.indirim01,
      this.indirim02,
      this.indirim03,
      this.indirim04,
      this.indirim05,
      this.indirim06,      
      this.maxmiktar,
      this.minmiktar,
      this.iskontohanesi,
      this.kampanyaadi,
      this.grupAdi,
      this.kampanyakodu,
      this.zorunlu
      });

  KampanyaYuzdeselSatir.fromJson(Map<String, dynamic> json) {
    rSayac = json['r_sayac'];
    kampanyaRsayac = json['kampanya_rsayac'];
    malzemeSinifi = json['malzeme_sinifi'];
    malzemeKodu = json['malzeme_kodu'];
    yuzde = json['yuzde'];
    kota = json['kota'];
    birim = json['birim'];
    miktarSarti = json['miktar_sarti'];
    noktaUygulama = json['nokta_uygulama'];
    cid = json['cid'];
    satisFiyati = json['satis_fiyati'];
    maxYuzde = json['max_yuzde'];
    grupKodu = json['grup_kodu'];
    indirim01 = json['indirim01'];
    indirim02 = json['indirim02'];
    indirim03 = json['indirim03'];
    indirim04 = json['indirim04'];
    indirim05 = json['indirim05'];
    indirim06 = json['indirim06'];    
    kampanyaadi = json['kampanya_adi'] == null ? "" : json['kampanya_adi'];
    maxmiktar = json['max_miktar'] == null ? 0 : json['max_miktar'];
    minmiktar = json['min_miktar'] == null ? 0 : json['min_miktar'];
    iskontohanesi = json['iskonto_hanesi'] == null ? 0 : json['iskonto_hanesi'];
    grupAdi=json['grup_adi'] == null ? "" : json['grup_adi'];
    kampanyakodu=json['kampanya_kodu'] == null ? "" : json['kampanya_kodu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r_sayac'] = this.rSayac;
    data['kampanya_rsayac'] = this.kampanyaRsayac;
    data['malzeme_sinifi'] = this.malzemeSinifi;
    data['malzeme_kodu'] = this.malzemeKodu;
    data['yuzde'] = this.yuzde;
    data['kota'] = this.kota;
    data['birim'] = this.birim;
    data['miktar_sarti'] = this.miktarSarti;
    data['nokta_uygulama'] = this.noktaUygulama;
    data['cid'] = this.cid;
    data['satis_fiyati'] = this.satisFiyati;
    data['max_yuzde'] = this.maxYuzde;
    data['grup_kodu'] = this.grupKodu;
    data['indirim01'] = this.indirim01;
    data['indirim02'] = this.indirim02;
    data['indirim03'] = this.indirim03;
    data['indirim04'] = this.indirim04;
    data['indirim05'] = this.indirim05;
    data['indirim06'] = this.indirim06;
    
    return data;
  }
}
