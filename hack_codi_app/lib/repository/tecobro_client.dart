import 'dart:async';
import 'dart:convert';
import 'package:hack_codi_app/model/create_codi_account_response.dart';
import 'package:http/http.dart' as http;
import 'package:hack_codi_app/model/tecobro.dart';
import 'package:hack_codi_app/config.dart';

class TeCobroClient {
  final http.Client httpClient;

  
  TeCobroClient({httpClient}) : this.httpClient = httpClient ?? http.Client();

  Future<SignInUpResponse> signup(SignInUpRequest request) async {
    http.Response responseRaw;

    try {
      responseRaw = await httpClient.post(
        Uri.parse("$baseUrl/users/signup"),
        body: jsonEncode(request.toJson()),
        headers: {"Content-type": "application/json"}
      );
    } catch (error) {
      throw 'Connection refused: $error';
    }
    
    if(responseRaw.statusCode < 200 || responseRaw.statusCode >= 300) {
        throw json.decode(responseRaw.body);
    }

    final responseJson = json.decode(responseRaw.body);

    return SignInUpResponse.fromJson(responseJson);
  }

  Future<SignInUpResponse> signin(SignInUpRequest request) async {
    http.Response responseRaw;

    try {
      responseRaw = await httpClient.post(
        Uri.parse("$baseUrl/users/signin"),
        body: jsonEncode(request.toJson()),
        headers: {"Content-type": "application/json"}
      );
    } catch (error) {
      throw 'Connection refused';
    }

    final responseJson = json.decode(responseRaw.body);

    if(responseRaw.statusCode < 200 || responseRaw.statusCode >= 300) {
      throw json.decode(responseRaw.body);
    }

    return SignInUpResponse.fromJson(responseJson);
  }

  Future<CreateCodiAccountResponse> createCodiAccount(CreateCodiAccountRequest request, String token) async {
    http.Response responseRaw;
    
    try {
      responseRaw = await httpClient.post(
        Uri.parse("$baseUrl/codi_accounts"),
        body: jsonEncode(request.toJson()),
        headers: {"auth": token}
      );
    } catch (error) {
      throw 'Connection refused';
    }

    final responseJson = json.decode(responseRaw.body);

    if(responseRaw.statusCode < 200 || responseRaw.statusCode >= 300) {
      throw json.decode(responseRaw.body);
    }

    return CreateCodiAccountResponse.fromJson(responseJson);
  }

}