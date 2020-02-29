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

class AcceptCameraButtonPressed extends SignupEvent {
  @override
  String toString() => 'AcceptCameraButtonPressed';
}

class RejectCameraButtonPressed extends SignupEvent {
  @override
  String toString() => 'RejectCameraButtonPressed';
}

class AcceptImagesButtonPressed extends SignupEvent {
  @override
  String toString() => 'AcceptImagesButtonPressed';
}

class RejectImagesButtonPressed extends SignupEvent {
  @override
  String toString() => 'RejectImagesButtonPressed';
}

class AcceptLocationButtonPressed extends SignupEvent {
  @override
  String toString() => 'AcceptLocationButtonPressed';
}

class RejectLocationButtonPressed extends SignupEvent {
  @override
  String toString() => 'RejectLocationButtonPressed';
}

class AcceptContactsButtonPressed extends SignupEvent {
  @override
  String toString() => 'AcceptContactsButtonPressed';
}

class RejectContactsButtonPressed extends SignupEvent {
  @override
  String toString() => 'RejectContactsButtonPressed';
}

class TCCheckBoxChanged extends SignupEvent {
  final bool value;

  TCCheckBoxChanged({@required this.value});

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'TCCheckBoxChanged { value: $value }';
}

class TermsAndConditionsButtonPressed extends SignupEvent {
  @override
  String toString() => 'TermsAndConditionsButtonPressed';
}

class RegisterButtonPressed extends SignupEvent {
  final String email;
  final String password;

  RegisterButtonPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'RegisterButtonPressed { email: $email, password: $password }';
}

class AcceptTCButtonPressed extends SignupEvent {
  @override
  String toString() => 'AcceptTCButtonPressed';
}

class ValidateButtonPressed extends SignupEvent {
  final String phone;

  ValidateButtonPressed({@required this.phone});

  @override
  List<Object> get props => [phone];

  @override
  String toString() => 'ValidateButtonPressed { phone: $phone }';
}

class SignupButtonPressed extends SignupEvent {
  final String codr;

  SignupButtonPressed({@required this.codr});

  @override
  List<Object> get props => [codr];

  @override
  String toString() => 'SignupButtonPressed { codr: $codr }';
}
