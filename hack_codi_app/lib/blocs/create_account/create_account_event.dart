part of 'create_account_bloc.dart';

abstract class CreateAccountEvent extends Equatable {
  const CreateAccountEvent();

  @override
  List<Object> get props => [];
}

class RetryButtonPressed extends CreateAccountEvent {
  @override
  String toString() => 'RetryButtonPressed';
}

class CreateAccountButtonPressed extends CreateAccountEvent {
  final String name;
  final String phoneNumber;
  final String address;

  CreateAccountButtonPressed(
    {
      @required this.name,
      @required this.phoneNumber,
      @required this.address
    }
  );

  @override
  List<Object> get props => [name, phoneNumber, address];

  @override
  String toString() => 'CreateAccountButtonPressed { name: $name, phone number: $phoneNumber, address: $address }';
}