//ValidationResponseList
import 'dart:convert';

List<ValidationResponseList> validationResponseListFromJson(String str) =>
    List<ValidationResponseList>.from(json.decode(str).map((x) => ValidationResponseList.fromJson(x)));

String validationResponseListToJson(List<ValidationResponseList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ValidationResponseList{
  bool successful;
  String code;
  String information;
  List<dynamic> result;

  ValidationResponseList({
    this.successful,
    this.code,
    this.information,
    this.result
  });

  factory ValidationResponseList.fromJson(Map<String, dynamic> json) => ValidationResponseList(
        successful: json["successful"],
        code: json["code"],
        information :json["information"],
        result: json["result"]!=null ? json["result"]:null
      );

  Map<String, dynamic> toJson() => {
        "successful": successful,
        "code": code,
        "information":information,
        "result":result
      };
}
