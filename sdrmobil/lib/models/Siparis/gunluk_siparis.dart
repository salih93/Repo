class GunlukSiparis {
  String malzemeKodu;
  String malzemeAdi;
  String bazBirim;
  String depoNo;
  String depoAdi;
  double miktar;
  double satirTutari;
  String grupAdi1;
  String grupAdi2;
  String grupAdi3;

  GunlukSiparis(
      {this.malzemeKodu,
      this.malzemeAdi,
      this.bazBirim,
      this.depoNo,
      this.depoAdi,
      this.miktar,
      this.satirTutari,
      this.grupAdi1,
      this.grupAdi2,
      this.grupAdi3});

  GunlukSiparis.fromJson(Map<String, dynamic> json) {
    malzemeKodu = json['malzeme_kodu'];
    malzemeAdi = json['malzeme_adi'];
    bazBirim = json['baz_birim'];
    depoNo = json['depo_no'];
    depoAdi = json['depo_adi'];
    miktar = json['miktar'];
    satirTutari = json['satir_tutari'];
    grupAdi1=json['grup_adi1'];
    grupAdi2=json['grup_adi2'];
    grupAdi3=json['grup_adi3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['malzeme_kodu'] = this.malzemeKodu;
    data['malzeme_adi'] = this.malzemeAdi;
    data['baz_birim'] = this.bazBirim;
    data['depo_no'] = this.depoNo;
    data['depo_adi'] = this.depoAdi;
    data['miktar'] = this.miktar;
    data['satir_tutari'] = this.satirTutari;
    data['grup_adi1']=this.grupAdi1;
    data['grup_adi2']=this.grupAdi2;
    data['grup_adi3']=this.grupAdi3;
        
    return data;
  }
}
