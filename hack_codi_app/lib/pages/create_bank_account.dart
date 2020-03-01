import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_codi_app/blocs/create_bank_account/create_bank_account_bloc.dart';
import 'package:hack_codi_app/common/botons.dart';
import 'package:hack_codi_app/blocs/create_bank_account/create_bank_account_bloc.dart';

class CreateBankAccount extends StatelessWidget {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final CreateBankAccountBloc _bloc = CreateBankAccountBloc();
  final List<String> _banks = ['Eligir Banco', 'Compartamos Banco', 'HSBC'];
  final String token;

  CreateBankAccount({Key key, @required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Apertura de Cuenta Bancaria"),),
      body: BlocBuilder<CreateBankAccountBloc, CreateBankAccountState>(
        bloc: _bloc,
        builder: (context, state) {
          if(state is AskingBankAccountInformation) {
            return _accountInformationForm(context, 'Eligir Banco');
          }

          if(state is ChoosingBank) {
            return _accountInformationForm(context, state.bank);
          }

          if(state is ShowingResult) {
            return _bankResultAlert(context);
          }

          if(state is CreateBankAccountError) {
            return Column(
              children: <Widget>[
                Text(state.error),
                teCobroBotton(
                  title: 'Reintentar',
                  handler: () => _bloc.add(RetryButtonPressed())
                )
              ],
            );
          }

          return Container();
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> getOptionsDropdown() {    
    List<DropdownMenuItem<String>> lista = new List();

    _banks.forEach( (poder) {
      lista.add( DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    });
    return lista;
  }

  Widget _accountInformationForm(BuildContext context, String bank) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('Banco:'),
            SizedBox(width: 10),
            Container(
              alignment: Alignment.topLeft,
              child: DropdownButton(
                value: bank,
                items: getOptionsDropdown(),
                onChanged: (valor) => _bloc.add(BankChoosen(bank: valor)),
              ),
            ),
          ],
        ),

        TextField(
          decoration: InputDecoration(labelText: 'Nombre'),
          controller: _nameController,
          autocorrect: false,
          enableSuggestions: false,
          enableInteractiveSelection: false,
        ),

        TextField(
          decoration: InputDecoration(labelText: 'Apellido'),
          controller: _lastNameController,
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
          keyboardType: TextInputType.phone,
        ),

        SizedBox(height: 10),

        teCobroBotton(
          title: 'Crear Cuenta',
          handler: () => _bloc.add(CreateBankAccountButtonPressed(
            bank: bank,
            name: _nameController.text,
            lastName: _lastNameController.text,
            phoneNumber: _phoneNumberController.text,
            token: token,
          )),
        )
      ],
    );
  }

  Widget _bankResultAlert(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15.0) ),
      title: Center(child: Text('¡Registro exitoso!')),
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
