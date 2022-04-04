import 'dart:convert';

import 'package:intl/intl.dart';

List<BekleyenSiparisGrupAdi> grupAdiFromJson(String str) =>
    List<BekleyenSiparisGrupAdi>.from(json.decode(str).map((x) => BekleyenSiparisGrupAdi.fromJson(x)));

String grupAdiToJson(List<BekleyenSiparisGrupAdi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BekleyenSiparisGrupAdi{
  int siparisno; 
  String unvan;
  String temsilciadi;
  DateTime siparistarihi;
  double tutar;
  double miktar;

  BekleyenSiparisGrupAdi({
    this.siparisno,
    this.unvan,
    this.temsilciadi,
    this.siparistarihi,
    this.tutar,
    this.miktar
  });

  
  BekleyenSiparisGrupAdi.fromJson(Map<String, dynamic> json) {
        siparisno= json["siparis_no"];
        unvan= json["unvan"];
        temsilciadi=json["temsilci_adi"];
        siparistarihi = json['siparis_tarihi'] == null ? null : DateTime.parse(json['siparis_tarihi']);
        tutar=json["tutar"];
        miktar=json["miktar"];
    }


   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

      data['siparis_no'] = this.siparisno;
      data['unvan'] = this.unvan;
      data['temsilci_adi'] = this.temsilciadi;      
      data['siparis_tarihi'] = DateFormat('yyyy-MM-dd 00:00:00.000').format(this.siparistarihi);
      data['tutar'] = this.tutar;
      data['miktar'] = this.miktar;
      
      return data;
    }
      
}
