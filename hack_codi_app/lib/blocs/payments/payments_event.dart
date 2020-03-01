part of 'payments_bloc.dart';

abstract class PaymentsEvent extends Equatable {
  const PaymentsEvent();

  @override
  List<Object> get props => [];
}

class CheckBoxChanged extends PaymentsEvent {
  final bool value;

  CheckBoxChanged({@required this.value});

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'CheckBoxChanged { value: $value }';
}