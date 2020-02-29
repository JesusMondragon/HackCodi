part of 'create_account_bloc.dart';

abstract class CreateAccountState extends Equatable {
  const CreateAccountState();

  @override
  List<Object> get props => [];
}

class AskingAccountInformation extends CreateAccountState { }


class CreatingAccount extends CreateAccountState { }

class CreateAccountError extends CreateAccountState {
  final String error;

  const CreateAccountError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CreateAccountError { error: $error }';
}

