
import 'package:meta/meta.dart';
import 'dart:convert';

CreateCodiAccountResponse createCodiAccountResponseFromJson(String str) => CreateCodiAccountResponse.fromJson(json.decode(str));

String createCodiAccountResponseToJson(CreateCodiAccountResponse data) => json.encode(data.toJson());

class CreateCodiAccountResponse {
    String id;

    CreateCodiAccountResponse({
        @required this.id,
    });

    factory CreateCodiAccountResponse.fromJson(Map<String, dynamic> json) => CreateCodiAccountResponse(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}
