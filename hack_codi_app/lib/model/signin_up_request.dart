
import 'package:meta/meta.dart';
import 'dart:convert';

SignInUpRequest signInUpRequestFromJson(String str) => SignInUpRequest.fromJson(json.decode(str));

String signInUpRequestToJson(SignInUpRequest data) => json.encode(data.toJson());

class SignInUpRequest {
    String email;
    String password;

    SignInUpRequest({
        @required this.email,
        @required this.password,
    });

    factory SignInUpRequest.fromJson(Map<String, dynamic> json) => SignInUpRequest(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}
