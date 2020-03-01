import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'create_codi_account_event.dart';
part 'create_codi_account_state.dart';


class CreateCodiAccountBloc extends Bloc<CreateCodiAccountEvent, CreateCodiAccountState> {
  
  @override
  CreateCodiAccountState get initialState => AskingCodiAccountInformation();

  @override
  Stream<CreateCodiAccountState> mapEventToState(CreateCodiAccountEvent event) async* {
    if(event is RetryButtonPressed) {
      yield AskingCodiAccountInformation();
    }

    if(event is CreateCodiAccountButtonPressed) {
      yield CreatingCodiAccount();

    }

  }
}
