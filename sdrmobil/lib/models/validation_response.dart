//ValidationResponse
import 'dart:convert';

List<ValidationResponse> validationResponseFromJson(String str) =>
    List<ValidationResponse>.from(json.decode(str).map((x) => ValidationResponse.fromJson(x)));

String validationResponseToJson(List<ValidationResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ValidationResponse{
  bool successful;
  String code;
  String information;
  String result;

  ValidationResponse({
    this.successful,
    this.code,
    this.information,
    this.result
  });

  factory ValidationResponse.fromJson(Map<String, dynamic> json) => ValidationResponse(
        successful: json["successful"],
        code: json["code"],
        information :json["information"],
        result: json["result"]
      );

  Map<String, dynamic> toJson() => {
        "successful": successful,
        "code": code,
        "information":information,
        "result":result
      };
}
