import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
  @override
  List<Object> get props => [];
}

class RetryButtonPressed extends SignupEvent {
  @override
  String toString() => 'RetryButtonPressed';
}

class SignupButtonPressed extends SignupEvent {
  final String email;
  final String password;

  SignupButtonPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'SignupButtonPressed { email: $email, password: $password }';
}
