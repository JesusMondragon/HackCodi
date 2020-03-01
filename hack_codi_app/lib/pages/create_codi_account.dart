import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_codi_app/blocs/create_codi_account/create_codi_account_bloc.dart';

class CreateCodiAccount extends StatelessWidget {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final CreateCodiAccountBloc _bloc = CreateCodiAccountBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Apertura de Cuenta CoDi"),),
      body: BlocBuilder<CreateCodiAccountBloc, CreateCodiAccountState>(
        bloc: _bloc,
        builder: (context, state) {
          if(state is AskingCodiAccountInformation) {
            return _accountInformationForm(context, 'Elijir Banco');
          }

          if(state is CreateCodiAccountError) {
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

  Widget _accountInformationForm(BuildContext context, String bank) {
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
          onPressed: () => _bloc.add(CreateCodiAccountButtonPressed(
            bank: bank,
            name: _nameController.text,
            phoneNumber: _phoneNumberController.text,
            address: _addressController.text
          )),
        ),
      ],
    );
  }

}
