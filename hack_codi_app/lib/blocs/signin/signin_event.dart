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
  final BuildContext context;

  SigninButtonPressed(
    {
      @required this.email,
      @required this.password,
      @required this.context
    }
  );

  @override
  List<Object> get props => [email, password, context];

  @override
  String toString() => 'SigninButtonPressed { email: $email, password: $password, contex: $context }';
}