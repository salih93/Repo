class BekleyenSiparisGruplu{
  String malzemekodu;
  String birimi;  
  double miktar;
  String bazbirim;
  
  BekleyenSiparisGruplu({this.malzemekodu, this.birimi, this.miktar, this.bazbirim});  

  factory BekleyenSiparisGruplu.fromJson(Map<String, dynamic> json) => BekleyenSiparisGruplu(
    malzemekodu: json["malzeme_kodu"],
    birimi: json["birimi"],
    miktar:json["miktar"],
    bazbirim:json["baz_birim"],
  );

}