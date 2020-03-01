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
  final String phoneNumber;
  final String bankAccountNumber;

  CreateCodiAccountButtonPressed(
    {
      @required this.phoneNumber,
      @required this.bankAccountNumber
    }
  );

  @override
  List<Object> get props => [phoneNumber, bankAccountNumber];

  @override
  String toString() => 'CreateCodiAccountButtonPressed { phoneNumber: $phoneNumber, Bank Account Number: $bankAccountNumber }';
}