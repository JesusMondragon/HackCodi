
import 'package:meta/meta.dart';
import 'dart:convert';

CreateCodiAccountResponse createCodiAccountResponseFromJson(String str) => CreateCodiAccountResponse.fromJson(json.decode(str));

String createCodiAccountResponseToJson(CreateCodiAccountResponse data) => json.encode(data.toJson());

class CreateCodiAccountResponse {
    String codiID;

    CreateCodiAccountResponse({
        @required this.codiID
    });

    factory CreateCodiAccountResponse.fromJson(Map<String, dynamic> json) => CreateCodiAccountResponse(
        codiID: json["id"]
    );

    Map<String, dynamic> toJson() => {
        "id": codiID
    };
}