part of 'create_codi_account_bloc.dart';

abstract class CreateCodiAccountState extends Equatable {
  const CreateCodiAccountState();

  @override
  List<Object> get props => [];
}

class AskingCodiAccountInformation extends CreateCodiAccountState { }

class CreatingCodiAccount extends CreateCodiAccountState { }

class ShowingResult extends CreateCodiAccountState { }

class CreateCodiAccountError extends CreateCodiAccountState {
  final String error;

  const CreateCodiAccountError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CreateCodiAccountError { error: $error }';
}

