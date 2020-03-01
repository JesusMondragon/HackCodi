import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hack_codi_app/model/create_bank_account_request.dart';
import 'package:hack_codi_app/model/create_bank_account_response.dart';
import 'package:meta/meta.dart';
import 'package:hack_codi_app/repository/tecobro_client.dart';

part 'create_bank_account_event.dart';
part 'create_bank_account_state.dart';


class CreateBankAccountBloc extends Bloc<CreateBankAccountEvent, CreateBankAccountState> {
  String _name;
  String _lastName;
  String _bank;
  String _phoneNumber;
  String _token;
  final teCobroClient = TeCobroClient();
  
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

      _name = event.name;
      _lastName = event.lastName;
      _phoneNumber = event.phoneNumber;
      _bank = event.bank;
      _token = event.token;

      CreateBankAccountRequest request = CreateBankAccountRequest(
        name: _name,
        lastName: _lastName,
        phoneNumber: _phoneNumber,
        bank: _bank
      );
      print(request.toJson());
      
      try {
        CreateBankAccountResponse response = await teCobroClient.createBankAccount(request, _token);
        print(response.toString());
        
      } catch (e) {
        yield CreateBankAccountError(error: e.toString());
        return;
      }

      yield ShowingResult();

    }

  }
}
