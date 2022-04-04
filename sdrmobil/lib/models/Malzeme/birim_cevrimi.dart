import 'dart:convert';

List<BirimCevrimi> birimCevrimiFromJson(String str) =>
    List<BirimCevrimi>.from(
        json.decode(str).map((x) => BirimCevrimi.fromJson(x)));

String birimCevrimiToJson(List<BirimCevrimi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BirimCevrimi {
        int rsayac;
        int birimrsayac;
        String birimden;
        String birime;
        double bolunen;
        double bolen;
        String malzemekodu;
        int anabirim;

    BirimCevrimi(
      {
        this.rsayac,
        this.birimrsayac,
        this.birimden,
        this.birime,
        this.bolunen,
        this.bolen,
        this.malzemekodu,
        this.anabirim
      });

  BirimCevrimi.fromJson(Map<String, dynamic> json) {
    rsayac = json['r_sayac'];
    birimrsayac = json['birim_rsayac'];
    birimden = json['birimden'];
    birime = json['birime'];
    bolunen = json['bolunen'];
    bolen = json['bolen'];
    malzemekodu = json['malzeme_kodu'];
    anabirim=json['ana_birim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r_sayac']=rsayac;
    data['birim_rsayac']=birimrsayac;
    data['birimden']=birimden;
    data['birime']=birime;
    data['bolunen']=bolunen;
    data['bolen']=bolen;
    data['malzeme_kodu']=malzemekodu;
    
    return data;
  }
}
