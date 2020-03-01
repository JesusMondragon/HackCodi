part of 'create_codi_account_bloc.dart';

abstract class CreateCodiAccountEvent extends Equatable {
  const CreateCodiAccountEvent();

  @override
  List<Object> get props => [];
}

class RetryButtonPressed extends CreateCodiAccountEvent {
  @override
  String toString() => 'RetryButtonPressed';
}

class BankChoosen extends CreateCodiAccountEvent {
  final String bank;

  BankChoosen({@required this.bank});

  @override
  List<Object> get props => [bank];

  @override
  String toString() => 'BankChoosen { value: $bank }';
}

class CreateCodiAccountButtonPressed extends CreateCodiAccountEvent {
  final String bank;
  final String name;
  final String phoneNumber;
  final String address;

  CreateCodiAccountButtonPressed(
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
  String toString() => 'CreateCodiAccountButtonPressed { bank: $bank, name: $name, phone number: $phoneNumber, address: $address }';
}