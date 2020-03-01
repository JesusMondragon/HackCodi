import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tecobro/blocs/password_reset/password_reset_bloc.dart';
import 'package:tecobro/common/botons.dart';

class PasswordReset extends StatelessWidget {
  final _emailController = TextEditingController();
  //ignore: close_sinks
  final PasswordResetBloc _bloc = PasswordResetBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Olvido de contraseña"),),
      body: BlocBuilder<PasswordResetBloc, PasswordResetState>(
        bloc: _bloc,
        builder: (context, state) {
          if(state is AskingEmail) {
            return Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Correo electrónico'),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                teCobroBotton(
                  title: 'Enviar',
                  handler: () => _bloc.add(SendButtonPressed(email: _emailController.text))
                ),
              ],
            );
          }

          return Container();
        }
      ),
    );
  }
}