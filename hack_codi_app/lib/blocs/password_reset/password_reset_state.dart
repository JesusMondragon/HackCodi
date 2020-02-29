part of 'password_reset_bloc.dart';

abstract class PasswordResetState extends Equatable {
  const PasswordResetState();

  @override
  List<Object> get props => [];
}

class AskingEmail extends PasswordResetState { }

class SendingEmail extends PasswordResetState { }

class PasswordResetError extends PasswordResetState {
  final String error;

  const PasswordResetError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PasswordResetError { error: $error }';
}