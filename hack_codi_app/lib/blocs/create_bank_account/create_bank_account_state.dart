part of 'create_bank_account_bloc.dart';

abstract class CreateBankAccountState extends Equatable {
  const CreateBankAccountState();

  @override
  List<Object> get props => [];
}

class AskingBankAccountInformation extends CreateBankAccountState { }

class CreatingBankAccount extends CreateBankAccountState { }

class ChoosingBank extends CreateBankAccountState {
  final String bank;

  const ChoosingBank({@required this.bank});

  @override
  List<Object> get props => [bank];

  @override
  String toString() => 'ChoosingBank { choosenBank: $bank}';
}

class CreateBankAccountError extends CreateBankAccountState {
  final String error;

  const CreateBankAccountError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CreateBankAccountError { error: $error }';
}

