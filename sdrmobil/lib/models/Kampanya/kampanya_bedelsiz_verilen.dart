class KampanyaBedelsizVerilen {
  int rSayac;
  int kampanyaRsayac;
  String malzemeKodu;
  double miktar;
  String cid;
  String birim;
  String grupKodu;
  int zorunlu;
  int hayatKampanya;
  int grupRsayac;
  String paket;
  int kota;
  String ustPaket;
  double birimfiyat;
  String kampanyaKodu;

  KampanyaBedelsizVerilen(
      {this.rSayac,
      this.kampanyaRsayac,
      this.malzemeKodu,
      this.miktar,
      this.cid,
      this.birim,
      this.grupKodu,
      this.zorunlu,
      this.hayatKampanya,
      this.grupRsayac,
      this.paket,
      this.kota,
      this.ustPaket,
      this.birimfiyat,
      this.kampanyaKodu
      });

  KampanyaBedelsizVerilen.fromJson(Map<String, dynamic> json) {
    rSayac = json['r_sayac'];
    kampanyaRsayac = json['kampanya_rsayac'];
    malzemeKodu = json['malzeme_kodu'];
    miktar = json['miktar'];
    cid = json['cid'];
    birim = json['birim'];
    grupKodu = json['grup_kodu'];
    zorunlu = json['zorunlu'];
    hayatKampanya = json['hayat_kampanya'];
    grupRsayac = json['grup_rsayac'];
    paket = json['paket'];
    kota = json['kota'];
    ustPaket = json['ust_paket'];
    birimfiyat =json['birim_fiyat']==null ? null : json['birim_fiyat'];
    kampanyaKodu =json['kampanya_kodu']==null ? null : json['kampanya_kodu'];    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r_sayac'] = this.rSayac;
    data['kampanya_rsayac'] = this.kampanyaRsayac;
    data['malzeme_kodu'] = this.malzemeKodu;
    data['miktar'] = this.miktar;
    data['cid'] = this.cid;
    data['birim'] = this.birim;
    data['grup_kodu'] = this.grupKodu;
    data['zorunlu'] = this.zorunlu;
    data['hayat_kampanya'] = this.hayatKampanya;
    data['grup_rsayac'] = this.grupRsayac;
    data['paket'] = this.paket;
    data['kota'] = this.kota;
    data['ust_paket'] = this.ustPaket;
    return data;
  }
}
