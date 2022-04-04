import 'dart:convert';

List<TahsilatSayisi> tahsilatSayisiFromJson(String str) =>
    List<TahsilatSayisi>.from(
        json.decode(str).map((x) => TahsilatSayisi.fromJson(x)));

String tahsilatSayisiToJson(List<TahsilatSayisi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TahsilatSayisi {
  int tahsilat;
  int rutdisi;
  int rutici;
  DateTime aktarimtarihi;

  TahsilatSayisi({
    this.tahsilat,
    this.rutici,
    this.rutdisi,
    this.aktarimtarihi
  });

  TahsilatSayisi.fromJson(Map<String, dynamic> json) {    
    tahsilat = json['tahsilat'];
    rutici = json['rut_ici'];
    rutdisi = json['rut_disi'];  
    aktarimtarihi= json['aktarim_tarihi']==null ? null:DateTime.parse(json['aktarim_tarihi']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tahsilat'] = this.tahsilat;
    data['rut_ici'] = this.rutici;
    data['rut_disi'] = this.rutdisi;
    data['aktarim_tarihi']=this.aktarimtarihi;
    
    return data;
  }


}
