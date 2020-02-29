import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  String _email = '';
  String _password = '';

  @override
  SignupState get initialState => AskingCameraPermission();

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if(event is RetryButtonPressed) {
      yield AskingEmailPassword();
    }

    if((event is AcceptCameraButtonPressed) || (event is RejectCameraButtonPressed) ) {
      yield AskingImagesPermission();
    }

    if((event is AcceptImagesButtonPressed) || (event is RejectImagesButtonPressed) ) {
      yield AskingLocationPermission();
    }

    if((event is AcceptLocationButtonPressed) || (event is RejectLocationButtonPressed) ) {
      yield AskingContactsPermission();
    }
    
    if((event is AcceptContactsButtonPressed) || (event is RejectContactsButtonPressed) ) {
      yield AskingEmailPassword();
    }

    if(event is TCCheckBoxChanged ) {
      yield ChangingTCCheckBox(newValue: event.value);
    }

    if(event is TermsAndConditionsButtonPressed) {
      yield DownloadingTC();

    }
    
    if(event is AcceptTCButtonPressed) {
      yield ChangingTCCheckBox(newValue: true);
    }
    
    if(event is RegisterButtonPressed) {
      yield SendingInfo();
      
      _email = event.email;
      _password = event.password;

      yield ShowingSignupResult();

      
    }


  }
}
