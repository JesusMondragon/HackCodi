import 'package:meta/meta.dart';
import 'dart:convert';

CreateBankAccountResponse createBankAccountResponseFromJson(String str) => CreateBankAccountResponse.fromJson(json.decode(str));

String createBankAccountResponseToJson(CreateBankAccountResponse data) => json.encode(data.toJson());

class CreateBankAccountResponse {
    String bankAccountNumber;

    CreateBankAccountResponse({
        @required this.bankAccountNumber,
    });

    factory CreateBankAccountResponse.fromJson(Map<String, dynamic> json) => CreateBankAccountResponse(
        bankAccountNumber: json["bank_account_number"],
    );

    Map<String, dynamic> toJson() => {
        "bank_account_number": bankAccountNumber,
    };
}