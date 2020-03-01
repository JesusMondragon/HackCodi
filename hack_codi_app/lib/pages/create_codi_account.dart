import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tecobro/blocs/create_codi_account/create_codi_account_bloc.dart';
import 'package:tecobro/common/botons.dart';

class CreateCodiAccount extends StatelessWidget {
  final _phoneNumberController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();
  final CreateCodiAccountBloc _bloc = CreateCodiAccountBloc();

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
                teCobroBotton(
                  title: 'Reintentar',
                  handler: () => _bloc.add(RetryButtonPressed())
                ),
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

        SizedBox(height: 10),

        teCobroBotton(
          title: 'Registro CoDi',
          handler: () => _bloc.add(CreateCodiAccountButtonPressed(
            phoneNumber: _phoneNumberController.text,
            bankAccountNumber: _bankAccountNumberController.text
          ))
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text('¿No tienes cuenta CLABE?'),
            FlatButton(
              onPressed: () => Navigator.pushNamed(context, '/create_bank_account'),
              child: Text("Abrir Cuenta")
            )
          ],
        ),
      ],
    );
  }

}
