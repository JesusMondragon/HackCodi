part of 'create_bank_account_bloc.dart';

abstract class CreateAccountEvent extends Equatable {
  const CreateAccountEvent();

  @override
  List<Object> get props => [];
}

class RetryButtonPressed extends CreateAccountEvent {
  @override
  String toString() => 'RetryButtonPressed';
}

class BankChoosen extends CreateAccountEvent {
  final String bank;

  BankChoosen({@required this.bank});

  @override
  List<Object> get props => [bank];

  @override
  String toString() => 'BankChoosen { value: $bank }';
}

class CreateAccountButtonPressed extends CreateAccountEvent {
  final String bank;
  final String name;
  final String phoneNumber;
  final String address;

  CreateAccountButtonPressed(
    {
      @required this.bank,
      @required this.name,
      @required this.phoneNumber,
      @required this.address
    }
  );

  @override
  List<Object> get props => [bank, name, phoneNumber, address];

  @override
  String toString() => 'CreateAccountButtonPressed { bank: $bank, name: $name, phone number: $phoneNumber, address: $address }';
}