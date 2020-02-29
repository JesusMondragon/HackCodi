part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class RetryButtonPressed extends SigninEvent {
  @override
  String toString() => 'RetryButtonPressed';
}

class SigninButtonPressed extends SigninEvent {
  final String email;
  final String password;

  SigninButtonPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'SigninButtonPressed { email: $email, password: $password }';
}