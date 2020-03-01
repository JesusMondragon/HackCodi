import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_codi_app/blocs/payments/payments_bloc.dart';

class Payments extends StatelessWidget {
  //ignore: close_sinks
  final PaymentsBloc _bloc = PaymentsBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Olvido de contraseña"),),
      body: BlocBuilder<PaymentsBloc, PaymentsState>(
        bloc: _bloc,
        builder: (context, state) {

          return Container();
        }
      ),
    );
  }
}