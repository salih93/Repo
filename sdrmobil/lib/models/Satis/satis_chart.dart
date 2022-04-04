import 'dart:convert';

List<SatisChart> satischartFromJson(String str) =>
    List<SatisChart>.from(json.decode(str).map((x) => SatisChart.fromJson(x)));

String satischartToJson(List<SatisChart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SatisChart {
  String unvan;
  String kod;
  double gunlukSiparisTutar;
  double gunlukFaturaTutar;
  double gunlukTahsilatTutar;

  SatisChart({
    this.kod,
    this.unvan,
    this.gunlukSiparisTutar,
    this.gunlukFaturaTutar,
    this.gunlukTahsilatTutar,
  });

  factory SatisChart.fromJson(Map<String, dynamic> json) => SatisChart(
        kod : json['kod'],
        unvan: json['unvan'],
        gunlukSiparisTutar: json['gunlukSiparisTutar'],
        gunlukFaturaTutar: json['gunlukFaturaTutar'],
        gunlukTahsilatTutar: json['gunlukTahsilatTutar'],
      );

  Map<String, dynamic> toJson() => {
        "kod" : kod,
        "unvan": unvan,
        "gunlukSiparisTutar": gunlukSiparisTutar,
        "gunlukFaturaTutar": gunlukFaturaTutar,
        "gunlukTahsilatTutar": gunlukTahsilatTutar,
      };
}
