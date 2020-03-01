import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_codi_app/blocs/create_codi_account/create_codi_account_bloc.dart';

class CreateCodiAccount extends StatelessWidget {
  final _phoneNumberController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();
  final CreateCodiAccountBloc _bloc = CreateCodiAccountBloc();
  final _buttonColor = Color(0xFF5130bb);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Apertura de Cuenta CoDi"),),
      body: BlocBuilder<CreateCodiAccountBloc, CreateCodiAccountState>(
        bloc: _bloc,
        builder: (context, state) {
          if(state is AskingCodiAccountInformation) {
            return _accountInformationForm(context);
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

  Widget _accountInformationForm(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: 'Celular'),
          controller: _phoneNumberController,
          autocorrect: false,
          enableSuggestions: false,
          enableInteractiveSelection: false,
          keyboardType: TextInputType.phone,
        ),

        TextField(
          decoration: InputDecoration(labelText: 'Cuenta Clabe Beneficiaría'),
          controller: _bankAccountNumberController,
          autocorrect: false,
          enableSuggestions: false,
          enableInteractiveSelection: false,
          keyboardType: TextInputType.number,
        ),

        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
            side: BorderSide(color: _buttonColor, width: 2.0)
          ),
          color: Colors.white,
          textColor: _buttonColor,
          child: Text('Registro CoDi'),
          onPressed: () => _bloc.add(CreateCodiAccountButtonPressed(
            phoneNumber: _phoneNumberController.text,
            bankAccountNumber: _bankAccountNumberController.text
          )),
        ),
      ],
    );
  }

}
