import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {

  @override
  PaymentsState get initialState => WithoutAmount();

  @override
  Stream<PaymentsState> mapEventToState(PaymentsEvent event) async* {
    if(event is CheckBoxChanged ) {
      yield ChangingCheckBox(newValue: event.value);
    }
  }



}