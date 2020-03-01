import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'create_bank_account_event.dart';
part 'create_bank_account_state.dart';


class CreateBankAccountBloc extends Bloc<CreateBankAccountEvent, CreateBankAccountState> {
  
  @override
  CreateBankAccountState get initialState => AskingBankAccountInformation();

  @override
  Stream<CreateBankAccountState> mapEventToState(CreateBankAccountEvent event) async* {
    if(event is RetryButtonPressed) {
      yield AskingBankAccountInformation();
    }

    if(event is BankChoosen) {
      yield ChoosingBank(bank: event.bank);

    }

    if(event is CreateBankAccountButtonPressed) {
      yield CreatingBankAccount();

    }

  }
}
