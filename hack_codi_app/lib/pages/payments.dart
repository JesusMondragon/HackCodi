import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_codi_app/blocs/payments/payments_bloc.dart';

class Payments extends StatelessWidget {
  final _amountController = TextEditingController();
  //ignore: close_sinks
  final PaymentsBloc _bloc = PaymentsBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cobro"),),
      body: BlocBuilder<PaymentsBloc, PaymentsState>(
        bloc: _bloc,
        builder: (context, state) {
          if(state is WithoutAmount) {
            return _paymentInformation(context, false);
          }

          print("Estado: $state");
          if(state is ChangingCheckBox) {
            print("XXXXX");
            return _paymentWithAmountInformation(context, state.newValue);
          }

          return Container();
        }
      ),
    );
  }

  Widget _paymentInformation(BuildContext context, bool tcCheckboxValue) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Checkbox(
              value: tcCheckboxValue,
              onChanged: (valor) => _bloc.add(CheckBoxChanged(value: valor)),
            ),
            Text("Con Monto", style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),),
          ],
        ),

        Expanded(
          child: Image(image: AssetImage('assets/qr_sin_importe.jpg'))
        ),

        Text('Código sin monto', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),)
      ],
    );
  }

  Widget _paymentWithAmountInformation(BuildContext context, bool tcCheckboxValue) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Checkbox(
              value: tcCheckboxValue,
              onChanged: (valor) => _bloc.add(CheckBoxChanged(value: valor)),
            ),
            Text("Con Monto", style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),),
          ],
        ),

        Expanded(
          child: Image(image: AssetImage('assets/qr_con_importe_2mxn.jpg'))
        ),

        TextField(
          decoration: InputDecoration(labelText: 'Monto'),
          controller: _amountController,
          autocorrect: false,
          enableSuggestions: false,
          enableInteractiveSelection: false,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }



}