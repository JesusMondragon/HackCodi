part of 'create_bank_account_bloc.dart';

abstract class CreateAccountState extends Equatable {
  const CreateAccountState();

  @override
  List<Object> get props => [];
}

class AskingAccountInformation extends CreateAccountState { }

class CreatingAccount extends CreateAccountState { }

class ChoosingBank extends CreateAccountState {
  final String bank;

  const ChoosingBank({@required this.bank});

  @override
  List<Object> get props => [bank];

  @override
  String toString() => 'ChoosingBank { choosenBank: $bank}';
}

class CreateAccountError extends CreateAccountState {
  final String error;

  const CreateAccountError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CreateAccountError { error: $error }';
}

