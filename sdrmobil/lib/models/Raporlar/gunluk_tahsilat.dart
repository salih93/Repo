import 'package:intl/intl.dart';

class GunlukTahsilat {
  String fisNo;
  int cariSayac;
  String fisTuru;
  DateTime tarih;
  String aktarimTemsilci;
  double tlAlacak;
  double tlBorc;
  String kasaKodu;
  String sorumlu;
  String cariKodu;
  String cariUnvan;

  GunlukTahsilat(
      {this.fisNo,
      this.cariSayac,
      this.fisTuru,
      this.tarih,
      this.aktarimTemsilci,
      this.tlAlacak,
      this.tlBorc,
      this.kasaKodu,
      this.sorumlu,
      this.cariKodu,
      this.cariUnvan});

  GunlukTahsilat.fromJson(Map<String, dynamic> json) {
    fisNo = json['fis_no'];
    cariSayac = json['cari_sayac'];
    fisTuru = json['fis_turu'];
    tarih = json['tarih'] == null ? null : DateTime.parse(json['tarih'].toString());
    aktarimTemsilci = json['aktarim_temsilci'];
    tlAlacak = json['tl_alacak'];
    tlBorc = json['tl_borc'];
    kasaKodu = json['kasa_kodu'];
    sorumlu = json['sorumlu'];
    cariKodu = json['cari_kodu'];
    cariUnvan = json['cari_unvan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fis_no'] = this.fisNo;
    data['cari_sayac'] = this.cariSayac;
    data['fis_turu'] = this.fisTuru;
    data['tarih'] = DateFormat('yyyy-MM-dd 00:00:00.000').format(this.tarih);
    data['aktarim_temsilci'] = this.aktarimTemsilci;
    data['tl_alacak'] = this.tlAlacak;
    data['tl_borc'] = this.tlBorc;
    data['kasa_kodu'] = this.kasaKodu;
    data['sorumlu'] = this.sorumlu;
    data['cari_kodu'] = this.cariKodu;
    data['cari_unvan'] = this.cariUnvan;
    return data;
  }
}
