import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_codi_app/blocs/payments/payments_bloc.dart';
import 'package:slider_button/slider_button.dart';

class Payments extends StatelessWidget {
  //ignore: close_sinks
  final PaymentsBloc _bloc = PaymentsBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cobro"),),
      body: BlocBuilder<PaymentsBloc, PaymentsState>(
        bloc: _bloc,
        builder: (context, state) {
          if(state is AskingAmount) {
            return _paymentInformation(context);
          }

          return Container();
        }
      ),
    );
  }

  Widget _paymentInformation(BuildContext context) {
    return Column(
      children: <Widget>[

        Center(child: SliderButton(
              action: () => { },
              label: Text(
                  "Sin monto",
                  style: TextStyle(
                      color: Color(0xff4a4a4a), fontWeight: FontWeight.w500, fontSize: 17),
                ),
              icon: Text(
                "x",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 44,
                ),
              ),
        )),

      ],
    );
  }


}