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
  final String lastName;
  final String phoneNumber;
  final String token;

  CreateBankAccountButtonPressed(
    {
      @required this.bank,
      @required this.name,
      @required this.lastName,
      @required this.phoneNumber,
      @required this.token
    }
  );

  @override
  List<Object> get props => [bank, name, lastName, phoneNumber, token];

  @override
  String toString() => 'CreateBankAccountButtonPressed { bank: $bank, name: $name, lastName: $lastName, phone number: $phoneNumber }';
}