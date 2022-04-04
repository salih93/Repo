import 'dart:convert';

List<CariVadeFarki> cariVadeFarkiFromJson(String str) =>
    List<CariVadeFarki>.from(
        json.decode(str).map((x) => CariVadeFarki.fromJson(x)));

String cariVadeFarkiToJson(List<CariVadeFarki> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CariVadeFarki {
  int id;
  String cariKodu;
  String cariUnvan;
  int faturaNo;
  String islemTipi;
  DateTime fisTarihi;
  int vadeGunSayisi;
  DateTime vadeTarihi;
  String borcAlacak;
  double tefatTutari;
  double tefatBakiyeTutari;
  double bakiyeToplami;
  String tahsilatGecikti;
  int gecikmeGunu;
  String sonBakiyeBakod;

  CariVadeFarki(
      {this.id,
      this.cariKodu,
      this.cariUnvan,
      this.faturaNo,
      this.islemTipi,
      this.fisTarihi,
      this.vadeGunSayisi,
      this.vadeTarihi,
      this.borcAlacak,
      this.tefatTutari,
      this.tefatBakiyeTutari,
      this.bakiyeToplami,
      this.tahsilatGecikti,
      this.gecikmeGunu,
      this.sonBakiyeBakod});

  CariVadeFarki.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cariKodu = json['cari_kodu'];
    cariUnvan = json['cari_unvan'];
    faturaNo = json['fatura_no'];
    islemTipi = json['islem_tipi'];
    fisTarihi = DateTime.parse(json['fis_tarihi'].toString());
    vadeGunSayisi = json['vade_gun_sayisi'];
    vadeTarihi = DateTime.parse(json['vade_tarihi'].toString());
    borcAlacak = json['borc_alacak'];
    tefatTutari = json['tefat_tutari'];
    tefatBakiyeTutari = json['tefat_bakiye_tutari'];
    bakiyeToplami = json['bakiye_toplami'];
    tahsilatGecikti = json['tahsilat_gecikti'];
    gecikmeGunu = json['gecikme_gunu'];
    sonBakiyeBakod = json['son_bakiye_bakod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cari_kodu'] = this.cariKodu;
    data['cari_unvan'] = this.cariUnvan;
    data['fatura_no'] = this.faturaNo;
    data['islem_tipi'] = this.islemTipi;
    data['fis_tarihi'] = this.fisTarihi.toString();
    data['vade_gun_sayisi'] = this.vadeGunSayisi;
    data['vade_tarihi'] = this.vadeTarihi.toString();
    data['borc_alacak'] = this.borcAlacak;
    data['tefat_tutari'] = this.tefatTutari;
    data['tefat_bakiye_tutari'] = this.tefatBakiyeTutari;
    data['bakiye_toplami'] = this.bakiyeToplami;
    data['tahsilat_gecikti'] = this.tahsilatGecikti;
    data['gecikme_gunu'] = this.gecikmeGunu;
    data['son_bakiye_bakod'] = this.sonBakiyeBakod;
    return data;
  }
}
