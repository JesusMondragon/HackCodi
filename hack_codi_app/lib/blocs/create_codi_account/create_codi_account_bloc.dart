import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hack_codi_app/model/create_codi_account_request.dart';
import 'package:hack_codi_app/model/create_codi_account_response.dart';
import 'package:meta/meta.dart';
import 'package:hack_codi_app/repository/tecobro_client.dart';

part 'create_codi_account_event.dart';
part 'create_codi_account_state.dart';


class CreateCodiAccountBloc extends Bloc<CreateCodiAccountEvent, CreateCodiAccountState> {
  String _phoneNumber = '';
  String _clabe = '';
  String _token;
  final teCobroClient = TeCobroClient();
  
  @override
  CreateCodiAccountState get initialState => AskingCodiAccountInformation();

  @override
  Stream<CreateCodiAccountState> mapEventToState(CreateCodiAccountEvent event) async* {
    if(event is RetryButtonPressed) {
      yield AskingCodiAccountInformation();
    }

    if(event is CreateCodiAccountButtonPressed) {
      yield CreatingCodiAccount();

      _phoneNumber = event.phoneNumber;
      _clabe = event.bankAccountNumber;
      _token = event.token;

      CreateCodiAccountRequest request = CreateCodiAccountRequest(
        phoneNumber: _phoneNumber,
        bankAccountNumber: _clabe
      );
      print(request.toJson());
      
      try {
        CreateCodiAccountResponse response = await teCobroClient.createCodiAccount(request, _token);
        print(response.toString());
        
      } catch (e) {
        yield CreateCodiAccountError(error: e.toString());
        return;
      }

      yield ShowingResult();
    }

  }
}
