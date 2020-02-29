import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_codi_app/blocs/create_account/create_account_bloc.dart';

class CreateAccount extends StatelessWidget {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final CreateAccountBloc _bloc = CreateAccountBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Apertura Cuenta"),),
      body: BlocBuilder<CreateAccountBloc, CreateAccountState>(
        bloc: _bloc,
        builder: (context, state) {
          if(state is AskingAccountInformation) {
            return _accountInformationForm(context, false);
          }

          if(state is CreateAccountError) {
            return Column(
              children: <Widget>[
                Text(state.error),
                RaisedButton(
                  child: Text('Reintentar'),
                  onPressed: () => _bloc.add(RetryButtonPressed()),
                )
              ],
            );
          }

          return Container();
        },
      ),
    );
  }


  Widget _accountInformationForm(BuildContext context, bool tcCheckboxValue) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: 'Nombre'),
          controller: _nameController,
          autocorrect: false,
          enableSuggestions: false,
          enableInteractiveSelection: false,
        ),

        TextField(
          decoration: InputDecoration(labelText: 'Celular'),
          controller: _phoneNumberController,
          autocorrect: false,
          enableSuggestions: false,
          enableInteractiveSelection: false,
        ),

        TextField(
          decoration: InputDecoration(labelText: 'Dirección'),
          controller: _addressController,
          autocorrect: false,
          enableSuggestions: false,
          enableInteractiveSelection: false,
        ),

        RaisedButton(
          child: Text('Crear Cuenta'),
          padding: EdgeInsets.symmetric(horizontal: 150.0),
          onPressed: () => _bloc.add(CreateAccountButtonPressed(
            name: _nameController.text,
            phoneNumber: _phoneNumberController.text,
            address: _addressController.text
          )),
        ),
      ],
    );
  }

}
