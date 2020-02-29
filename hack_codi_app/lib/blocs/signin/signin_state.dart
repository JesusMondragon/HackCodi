part of 'signin_bloc.dart';

abstract class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

class AskingEmailPassword extends SigninState { }


class SigningIn extends SigninState { }

class SigninError extends SigninState {
  final String error;

  const SigninError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SigninError { error: $error }';
}

