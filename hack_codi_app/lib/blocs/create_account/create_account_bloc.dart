import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'create_account_event.dart';
part 'create_account_state.dart';


class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  
  @override
  CreateAccountState get initialState => AskingAccountInformation();

  @override
  Stream<CreateAccountState> mapEventToState(CreateAccountEvent event) async* {
    if(event is RetryButtonPressed) {
      yield AskingAccountInformation();
    }

    if(event is CreateAccountButtonPressed) {
      yield CreatingAccount();

    }

  }
}
