import 'dart:convert';

List<AktarimParameterModel> aktarimParameterModelFromJson(String str) =>
    List<AktarimParameterModel>.from(json.decode(str).map((x) => AktarimParameterModel.fromJson(x)));

String aktarimParameterModelToJson(List<AktarimParameterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AktarimParameterModel {
  String temsilcikodu;
  String veritabaniadi;  
  String userid;
  String androidversiyon;
  String token;
  String email;

  AktarimParameterModel({
    this.temsilcikodu,
    this.veritabaniadi,
    this.userid,
    this.androidversiyon,
    this.token,
    this.email
  });

  factory AktarimParameterModel.fromJson(Map<String, dynamic> json) => AktarimParameterModel(
        temsilcikodu: json["temsilci_kodu"],
        veritabaniadi: json["veritabani_adi"],
        userid:json["user_id"],
        androidversiyon: json["android_versiyon"],
        token:json["token"],
        email: json["email"]
      );

  Map<String, dynamic> toJson() => {
        "temsilci_kodu": temsilcikodu,
        "veritabani_adi": veritabaniadi,
        "user_id":userid,
        "android_versiyon" : androidversiyon,
        "token":token,
        "email":email
      };
}
