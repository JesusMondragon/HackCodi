
import 'package:meta/meta.dart';
import 'dart:convert';

CreateCodiAccountRequest createCodiAccountRequestFromJson(String str) => CreateCodiAccountRequest.fromJson(json.decode(str));

String createCodiAccountRequestToJson(CreateCodiAccountRequest data) => json.encode(data.toJson());

class CreateCodiAccountRequest {
    String phoneNumber;
    String bankAccountNumber;

    CreateCodiAccountRequest({
        @required this.phoneNumber,
        @required this.bankAccountNumber,
    });

    factory CreateCodiAccountRequest.fromJson(Map<String, dynamic> json) => CreateCodiAccountRequest(
        phoneNumber: json["phone_number"],
        bankAccountNumber: json["clabe"],
    );

    Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "clabe": bankAccountNumber,
    };
}
