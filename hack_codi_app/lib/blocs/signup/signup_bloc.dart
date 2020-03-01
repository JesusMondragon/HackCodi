import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hack_codi_app/repository/tecobro_client.dart';
import 'package:hack_codi_app/model/tecobro.dart';
import './bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  String _email = '';
  String _password = '';
  final teCobroClient = TeCobroClient();

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

    if(event is SignupButtonPressed) {
      yield SendingInfo();
      
      _email = event.email;
      _password = event.password;

      SignInUpRequest request = SignInUpRequest(
        email: _email,
        password: _password
      );
      print(request.toJson());
      
      try {
        SignInUpResponse response = await teCobroClient.signup(request);
        print(response.toString());
        
      } catch (e) {
        yield SignupError(error: e.toString());
        return;
      }

      yield ShowingSignupResult();
    }


  }
}
