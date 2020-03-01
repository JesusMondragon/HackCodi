
import 'package:meta/meta.dart';
import 'dart:convert';

SignupResponse signupResponseFromJson(String str) => SignupResponse.fromJson(json.decode(str));

String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());

class SignupResponse {
    String token;
    String userIdentifier;

    SignupResponse({
        @required this.token,
        @required this.userIdentifier,
    });

    factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
        token: json["token"],
        userIdentifier: json["userIdentifier"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "userIdentifier": userIdentifier,
    };
}