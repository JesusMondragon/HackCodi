import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_codi_app/blocs/create_bank_account/create_bank_account_bloc.dart';
import 'package:hack_codi_app/common/botons.dart';

class CreateBankAccount extends StatelessWidget {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final CreateBankAccountBloc _bloc = CreateBankAccountBloc();

  final List<String> _banks = ['Eligir Banco', 'Compartamos Banco', 'HSBC'];

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
          decoration: InputDecoration(labelText: 'Celular'),
          controller: _phoneNumberController,
          autocorrect: false,
          enableSuggestions: false,
          enableInteractiveSelection: false,
          keyboardType: TextInputType.phone,
        ),

        TextField(
          decoration: InputDecoration(labelText: 'Dirección'),
          controller: _addressController,
          autocorrect: false,
          enableSuggestions: false,
          enableInteractiveSelection: false,
        ),

        SizedBox(height: 10),

        teCobroBotton(
          title: 'Crear Cuenta',
          handler: () => _bloc.add(CreateBankAccountButtonPressed(
            bank: bank,
            name: _nameController.text,
            phoneNumber: _phoneNumberController.text,
            address: _addressController.text
          )),
        )
      ],
    );
  }

}
