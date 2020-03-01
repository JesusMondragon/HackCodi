import 'package:meta/meta.dart';
import 'dart:convert';

CreateBankAccountRequest createBankAccountRequestFromJson(String str) => CreateBankAccountRequest.fromJson(json.decode(str));

String createBankAccountRequestToJson(CreateBankAccountRequest data) => json.encode(data.toJson());

class CreateBankAccountRequest {
    String name;
    String phoneNumber;
    String address;
    String bank;

    CreateBankAccountRequest({
        @required this.name,
        @required this.phoneNumber,
        @required this.address,
        @required this.bank,
    });

    factory CreateBankAccountRequest.fromJson(Map<String, dynamic> json) => CreateBankAccountRequest(
        name: json["name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        bank: json["bank"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone_number": phoneNumber,
        "address": address,
        "bank": bank,
    };
}