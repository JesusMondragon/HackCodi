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

class SignupButtonPressed extends SignupEvent {
  final String email;
  final String password;

  SignupButtonPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'SignupButtonPressed { email: $email, password: $password }';
}
