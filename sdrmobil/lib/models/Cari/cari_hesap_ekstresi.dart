import 'dart:convert';

List<CariHesapEkstresi> carihesapEkstreFromJson(String str) =>
    List<CariHesapEkstresi>.from(
        json.decode(str).map((x) => CariHesapEkstresi.fromJson(x)));

String carihesapEkstreToJson(List<CariHesapEkstresi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CariHesapEkstresi {
  int id;
  String cariKodu;
  String cariUnvan;
  DateTime evrakTarihi;
  String fisNo;
  String resmiBelgeNo;
  String aciklama;
  double borc;
  double alacak;
  double bakiye;
  String bakiyeBorcAlacak;
  DateTime vadeTarihi;
  String  fisturu;

  CariHesapEkstresi(
      {this.id,
      this.cariKodu,
      this.cariUnvan,
      this.evrakTarihi,
      this.fisNo,
      this.resmiBelgeNo,
      this.aciklama,
      this.borc,
      this.alacak,
      this.bakiye,
      this.bakiyeBorcAlacak,
      this.vadeTarihi,
      this.fisturu});

  CariHesapEkstresi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cariKodu = json['cari_kodu'];
    cariUnvan = json['cari_unvan'];
    evrakTarihi = DateTime.parse(json['evrak_tarihi'].toString());
    fisNo = json['fis_no'];
    resmiBelgeNo = json['resmi_belge_no'];
    aciklama = json['aciklama'];
    borc = json['borc'];
    alacak = json['alacak'];
    bakiye = json['bakiye'];
    bakiyeBorcAlacak = json['bakiye_borc_alacak'];
    vadeTarihi = DateTime.parse(json['vade_tarihi'].toString());
    fisturu=json['fis_turu']==null ? "":json['fis_turu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cari_kodu'] = this.cariKodu;
    data['cari_unvan'] = this.cariUnvan;
    data['evrak_tarihi'] = this.evrakTarihi.toString();
    data['fis_no'] = this.fisNo;
    data['resmi_belge_no'] = this.resmiBelgeNo;
    data['aciklama'] = this.aciklama;
    data['borc'] = this.borc;
    data['alacak'] = this.alacak;
    data['bakiye'] = this.bakiye;
    data['bakiye_borc_alacak'] = this.bakiyeBorcAlacak;
    data['vade_tarihi'] = this.vadeTarihi.toString();
    data['fis_turu']=this.fisturu;
    
    return data;
  }
}
