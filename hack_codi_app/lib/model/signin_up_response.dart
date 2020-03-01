
import 'package:meta/meta.dart';
import 'dart:convert';

SignInUpResponse signInUpResponseFromJson(String str) => SignInUpResponse.fromJson(json.decode(str));

String signInUpResponseToJson(SignInUpResponse data) => json.encode(data.toJson());

class SignInUpResponse {
    String token;
    String userIdentifier;

    SignInUpResponse({
        @required this.token,
        @required this.userIdentifier,
    });

    factory SignInUpResponse.fromJson(Map<String, dynamic> json) => SignInUpResponse(
        token: json["token"],
        userIdentifier: json["userIdentifier"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "userIdentifier": userIdentifier,
    };
}