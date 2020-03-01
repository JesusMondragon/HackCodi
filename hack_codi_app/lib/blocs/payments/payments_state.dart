part of 'payments_bloc.dart';

abstract class PaymentsState extends Equatable {
  const PaymentsState();

  @override
  List<Object> get props => [];
}

class WithAmount extends PaymentsState { }

class WithoutAmount extends PaymentsState { }

class ChangingCheckBox extends PaymentsState {
  final bool newValue;

  const ChangingCheckBox({@required this.newValue});

  @override
  List<Object> get props => [newValue];

  @override
  String toString() => 'ChangingCheckBox { CheckBox newValue: $newValue}';
}