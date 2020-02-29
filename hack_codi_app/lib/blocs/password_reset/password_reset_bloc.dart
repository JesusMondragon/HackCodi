import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {

  @override
  PasswordResetState get initialState => AskingEmail();

  @override
  Stream<PasswordResetState> mapEventToState(PasswordResetEvent event) async* {

  }



}