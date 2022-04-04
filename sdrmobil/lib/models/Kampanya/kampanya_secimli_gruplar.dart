class KampanyaSecimliGruplar {
  int rSayac;
  String cid;
  int kampanyaRsayac;
  String grupKodu;
  String grupAdi;
  String anaGrupKodu;
  double grupToplamMiktar;
  double maxMiktar;
  double bedelsizGrupToplamMiktar;
  int iskontoHanesi;
  double minMiktar;
  int bayiKota;
  int cariKota;

  KampanyaSecimliGruplar(
      {this.rSayac,
      this.cid,
      this.kampanyaRsayac,
      this.grupKodu,
      this.grupAdi,
      this.anaGrupKodu,
      this.grupToplamMiktar,
      this.maxMiktar,
      this.bedelsizGrupToplamMiktar,
      this.iskontoHanesi,
      this.minMiktar,
      this.bayiKota,
      this.cariKota});

  KampanyaSecimliGruplar.fromJson(Map<String, dynamic> json) {
    rSayac = json['r_sayac'];
    cid = json['cid'];
    kampanyaRsayac = json['kampanya_rsayac'];
    grupKodu = json['grup_kodu'];
    grupAdi = json['grup_adi'];
    anaGrupKodu = json['ana_grup_kodu'];
    grupToplamMiktar = json['grup_toplam_miktar'];
    maxMiktar = json['max_miktar'];
    bedelsizGrupToplamMiktar = json['bedelsiz_grup_toplam_miktar'];
    iskontoHanesi = json['iskonto_hanesi'];
    minMiktar = json['min_miktar'];
    bayiKota = json['bayi_kota'];
    cariKota = json['cari_kota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r_sayac'] = this.rSayac;
    data['cid'] = this.cid;
    data['kampanya_rsayac'] = this.kampanyaRsayac;
    data['grup_kodu'] = this.grupKodu;
    data['grup_adi'] = this.grupAdi;
    data['ana_grup_kodu'] = this.anaGrupKodu;
    data['grup_toplam_miktar'] = this.grupToplamMiktar;
    data['max_miktar'] = this.maxMiktar;
    data['bedelsiz_grup_toplam_miktar'] = this.bedelsizGrupToplamMiktar;
    data['iskonto_hanesi'] = this.iskontoHanesi;
    data['min_miktar'] = this.minMiktar;
    data['bayi_kota'] = this.bayiKota;
    data['cari_kota'] = this.cariKota;
    return data;
  }
}
