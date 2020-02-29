import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class AskingCameraPermission extends SignupState { }

class AskingImagesPermission extends SignupState { }

class AskingLocationPermission extends SignupState { }

class AskingContactsPermission extends SignupState { }

class AskingEmailPassword extends SignupState { }

class ChangingTCCheckBox extends SignupState {
  final bool newValue;

  const ChangingTCCheckBox({@required this.newValue});

  @override
  List<Object> get props => [newValue];

  @override
  String toString() => 'ChangingTCCheckBox { TCCheckBox newValue: $newValue}';
}

class DownloadingTC extends SignupState { }

class ShowingTC extends SignupState {
  final String tc;

  const ShowingTC({@required this.tc});

  @override
  List<Object> get props => [tc];

  @override
  String toString() => 'SignupError { T&C: $tc }';

}

class AskingPhoneNumber extends SignupState { }

class SendingInfo extends SignupState { }

class ShowingSignupResult extends SignupState { }

class AskingCodR extends SignupState { }

class SignupError extends SignupState {
  final String error;

  const SignupError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SignupError { error: $error }';
}
