import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';


class SigninBloc extends Bloc<SigninEvent, SigninState> {
  
  @override
  SigninState get initialState => AskingEmailPassword();

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    if(event is RetryButtonPressed) {
      yield AskingEmailPassword();
    }

    if(event is SigninButtonPressed) {
      yield SigningIn();

    }

  }
}
