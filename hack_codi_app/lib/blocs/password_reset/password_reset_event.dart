part of 'password_reset_bloc.dart';

abstract class PasswordResetEvent extends Equatable {
  const PasswordResetEvent();

  @override
  List<Object> get props => [];
}

class SendButtonPressed extends PasswordResetEvent {
  final String email;

  SendButtonPressed({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'SigninButtonPressed { email: $email }';

}