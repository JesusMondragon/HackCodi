import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:hack_codi_app/model/tecobro.dart';
import 'package:hack_codi_app/repository/tecobro_client.dart';
import 'package:hack_codi_app/pages/create_codi_account.dart';

part 'signin_event.dart';
part 'signin_state.dart';


class SigninBloc extends Bloc<SigninEvent, SigninState> {
  String _email = '';
  String _password = '';
  final teCobroClient = TeCobroClient();

  @override
  SigninState get initialState => AskingEmailPassword();

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    if(event is RetryButtonPressed) {
      yield AskingEmailPassword();
    }

    if(event is SigninButtonPressed) {
      yield SigningIn();
      
      _email = event.email;
      _password = event.password;

      SignInUpRequest request = SignInUpRequest(
        email: _email,
        password: _password
      );
      print(request.toJson());
      
      try {
        SignInUpResponse response = await teCobroClient.signin(request);
        print(response.toString());
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => CreateCodiAccount(token: response.token)
          )
        );        
      } catch (e) {
        yield SigninError(error: e.toString());
        return;
      }
    }

  }
}
