import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_codi_app/blocs/create_codi_account/create_codi_account_bloc.dart';
import 'package:hack_codi_app/common/botons.dart';

class CreateCodiAccount extends StatelessWidget {
  final _phoneNumberController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();
  final CreateCodiAccountBloc _bloc = CreateCodiAccountBloc();
  final String token;

  CreateCodiAccount({Key key, @required this.token}) : super(key: key);

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

          if(state is CreatingCodiAccount) {
            return _progressIndicatorAlert(context);
          }

          if(state is ShowingResult)
          {
            _codiAccountResultAlert(context);
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
            bankAccountNumber: _bankAccountNumberController.text,
            token: token,
          ))
        ),

        SizedBox(height: 50),


        teCobroBotton(
          title: 'Crear Cuenta Bancaria',
          handler: () => Navigator.pushNamed(context, '/create_bank_account')
        ),
        
        Center(
          child: Text('¿No tienes Cuenta Clabe?')
        )

      ],
    );
  }

    Widget _progressIndicatorAlert(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15.0) ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
          Text('Registrando...')
        ],
      ),
    );
  }

  Widget _codiAccountResultAlert(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15.0) ),
      title: Center(child: Text('¡Registro CoDi exitoso!')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon( Icons.check, color: Colors.blue, size: 80.0, ),
          teCobroBotton(
            title: 'ACEPTAR',
            handler: () => Navigator.pushNamed(context, '/payments')
          ),
        ],
      ),
    );
  }


}
