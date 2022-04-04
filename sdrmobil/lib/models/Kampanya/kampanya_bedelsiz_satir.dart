class KampanyaBedelsizSatir {
  int rSayac;
  int kampanyaRsayac;
  String malzemeSinifi;
  String malzemeKodu;
  double kota;
  String birim;
  double miktarSarti;
  int noktaUygulama;
  String cid;
  double satisFiyati;
  String grupKodu;
  String paket;
  String dist;
  String anlasmaDurumu;
  String ustGrup;
  String kademe;
  String musteriTipi;
  int grupRsayac;
  double kalanMiktar;
  String ustPaket;
  String cariKod;
  double gruptoplammiktar;
  double bedelsizgruptoplammiktar;
  int iskontohanesi;
  String kampanyaadi;
  String grupAdi;
  
  KampanyaBedelsizSatir(
      {this.rSayac,
      this.kampanyaRsayac,
      this.malzemeSinifi,
      this.malzemeKodu,
      this.kota,
      this.birim,
      this.miktarSarti,
      this.noktaUygulama,
      this.cid,
      this.satisFiyati,
      this.grupKodu,
      this.paket,
      this.dist,
      this.anlasmaDurumu,
      this.ustGrup,
      this.kademe,
      this.musteriTipi,
      this.grupRsayac,
      this.kalanMiktar,
      this.ustPaket,
      this.cariKod,
      this.gruptoplammiktar,
      this.bedelsizgruptoplammiktar,
      this.iskontohanesi,
      this.kampanyaadi,
      this.grupAdi
      });

  KampanyaBedelsizSatir.fromJson(Map<String, dynamic> json) {
    rSayac = json['r_sayac'];
    kampanyaRsayac = json['kampanya_rsayac'];
    malzemeSinifi = json['malzeme_sinifi'];
    malzemeKodu = json['malzeme_kodu'];
    kota = json['kota'];
    birim = json['birim'];
    miktarSarti = json['miktar_sarti'];
    noktaUygulama = json['nokta_uygulama'];
    cid = json['cid'];
    satisFiyati = json['satis_fiyati'];
    grupKodu = json['grup_kodu'];
    paket = json['paket'];
    dist = json['dist'];
    anlasmaDurumu = json['anlasma_durumu'];
    ustGrup = json['ust_grup'];
    kademe = json['kademe'];
    musteriTipi = json['musteri_tipi'];
    grupRsayac = json['grup_rsayac'];
    kalanMiktar = json['kalan_miktar'];
    ustPaket = json['ust_paket'];
    cariKod = json['cari_kod'];
    kampanyaadi = json['kampanya_adi'] == null ? null : json['kampanya_adi'];
    gruptoplammiktar = json['grup_toplam_miktar']==null ? null:json['grup_toplam_miktar'];
    bedelsizgruptoplammiktar = json['bedelsiz_grup_toplam_miktar']==null ? null:json['bedelsiz_grup_toplam_miktar'];
    iskontohanesi = json['iskonto_hanesi']==null ? null:json['iskonto_hanesi'];
    grupAdi=json['grup_adi'] == null ? "" : json['grup_adi'];    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r_sayac'] = this.rSayac;
    data['kampanya_rsayac'] = this.kampanyaRsayac;
    data['malzeme_sinifi'] = this.malzemeSinifi;
    data['malzeme_kodu'] = this.malzemeKodu;
    data['kota'] = this.kota;
    data['birim'] = this.birim;
    data['miktar_sarti'] = this.miktarSarti;
    data['nokta_uygulama'] = this.noktaUygulama;
    data['cid'] = this.cid;
    data['satis_fiyati'] = this.satisFiyati;
    data['grup_kodu'] = this.grupKodu;
    data['paket'] = this.paket;
    data['dist'] = this.dist;
    data['anlasma_durumu'] = this.anlasmaDurumu;
    data['ust_grup'] = this.ustGrup;
    data['kademe'] = this.kademe;
    data['musteri_tipi'] = this.musteriTipi;
    data['grup_rsayac'] = this.grupRsayac;
    data['kalan_miktar'] = this.kalanMiktar;
    data['ust_paket'] = this.ustPaket;
    data['cari_kod'] = this.cariKod;
    return data;
  }
}
