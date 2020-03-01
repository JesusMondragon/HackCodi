part of 'create_bank_account_bloc.dart';

abstract class CreateBankAccountEvent extends Equatable {
  const CreateBankAccountEvent();

  @override
  List<Object> get props => [];
}

class RetryButtonPressed extends CreateBankAccountEvent {
  @override
  String toString() => 'RetryButtonPressed';
}

class BankChoosen extends CreateBankAccountEvent {
  final String bank;

  BankChoosen({@required this.bank});

  @override
  List<Object> get props => [bank];

  @override
  String toString() => 'BankChoosen { value: $bank }';
}

class CreateBankAccountButtonPressed extends CreateBankAccountEvent {
  final String bank;
  final String name;
  final String phoneNumber;
  final String address;
  final String token;

  CreateBankAccountButtonPressed(
    {
      @required this.bank,
      @required this.name,
      @required this.phoneNumber,
      @required this.address,
      @required this.token
    }
  );

  @override
  List<Object> get props => [bank, name, phoneNumber, address, token];

  @override
  String toString() => 'CreateBankAccountButtonPressed { bank: $bank, name: $name, phone number: $phoneNumber, address: $address }';
}