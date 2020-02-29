import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_codi_app/blocs/signin/signin_bloc.dart';

class Signin extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  //ignore: close_sinks
  final SigninBloc _bloc = SigninBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Acceso"),),
        body: BlocBuilder<SigninBloc, SigninState>(
        bloc: _bloc,
        builder: (context, state) {
          if(state is  AskingEmailPassword) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Image(image: AssetImage('assets/logo.jpg'))
                ),

                TextField(
                  decoration: InputDecoration(labelText: 'Correo Electrónico'),
                  controller: _emailController,
                  autocorrect: false,
                  enableSuggestions: false,
                  enableInteractiveSelection: false,
                ),

                TextField(
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  controller: _passwordController,
                  autocorrect: false,
                  enableSuggestions: false,
                  enableInteractiveSelection: false,
                  obscureText: true,
                ),

                FlatButton(
                  onPressed: () => Navigator.pushNamed(context, '/password_reset'),
                  child: Text('¿Olvidaste tu contraseña?')
                ),

                RaisedButton(
                  child: Text('Continuar'),
                  onPressed: () => _bloc.add(SigninButtonPressed(
                    email: _emailController.text,
                    password: _passwordController.text
                  )),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Text('¿No tienes cuenta?'),
                    FlatButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      child: Text("Registrate")
                    )
                  ],
                ),

              ],
            );
          }

          if(state is SigningIn) {
              return Center(child: CircularProgressIndicator());
          }

          if(state is SigninError) {
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
        }
      ),
    );
  }
}