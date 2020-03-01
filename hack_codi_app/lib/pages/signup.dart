import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tecobro/blocs/signup/bloc.dart';
import 'package:tecobro/common/botons.dart';

class Signup extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final SignupBloc _bloc = SignupBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro"),),
      body: BlocBuilder<SignupBloc, SignupState>(
        bloc: _bloc,
        builder: (context, state) {
          if(state is AskingCameraPermission) {
            return _cameraPermissionAlert(context);
          }

          if(state is AskingImagesPermission) {
            return _imagesPermissionAlert(context);
          }

          if(state is AskingLocationPermission) {
            return _locationPermissionAlert(context);
          }

          if(state is AskingContactsPermission) {
            return _contactsPermissionAlert(context);
          }

          if(state is AskingEmailPassword) {
            return _signupForm(context, false);
          }

          if(state is SendingInfo) {
            return _progressIndicatorAlert(context);
          }

          if(state is ShowingSignupResult) {
            return _signupResultAlert(context);
          }

          if(state is SignupError) {
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


  Widget _signupForm(BuildContext context, bool tcCheckboxValue) {
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
          keyboardType: TextInputType.emailAddress,
        ),

        TextField(
          decoration: InputDecoration(labelText: 'Contraseña'),
          controller: _passwordController,
          autocorrect: false,
          enableSuggestions: false,
          enableInteractiveSelection: false,
          obscureText: true,
        ),

        TextField(
          decoration: InputDecoration(labelText: 'Confirmar contraseña'),
          autocorrect: false,
          enableSuggestions: false,
          enableInteractiveSelection: false,
          obscureText: true,
        ),

        SizedBox(height: 10.0,),

        teCobroBotton(
          title: 'Registrarme',
          handler: () => _bloc.add(SignupButtonPressed(
            email: _emailController.text,
            password: _passwordController.text
          ))
        ),

        FlatButton(
          child: Text('¡Ya tengo cuenta!'),
          padding: EdgeInsets.only(left: 250),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _cameraPermissionAlert(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15.0) ),
      title: Text('Permiso para acceder a la cámara'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Se debe tener acceso a la cámara para poder leer códigos QR')
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('RECHAZAR'),
          onPressed: () => _bloc.add( RejectCameraButtonPressed() ),
        ),
        FlatButton(
          child: Text('PERMITIR'),
          onPressed: () => _bloc.add( AcceptCameraButtonPressed() ),
        ),
      ],
    );
  }

  Widget _imagesPermissionAlert(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15.0) ),
      title: Text('Permiso para acceder a imágenes'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Se debe tener acceso a las imágenes para poder almacenar códigos QR')
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('RECHAZAR'),
          onPressed: () => _bloc.add( RejectImagesButtonPressed() ),
        ),
        FlatButton(
          child: Text('PERMITIR'),
          onPressed: () => _bloc.add( AcceptImagesButtonPressed() ),
        ),
      ],
    );
  }

  Widget _locationPermissionAlert(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15.0) ),
      title: Text('Permiso para acceder a la localización'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Con el acceso a tu localización se te pueden ofrecer servicios personalizados')
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('RECHAZAR'),
          onPressed: () => _bloc.add( RejectLocationButtonPressed() ),
        ),
        FlatButton(
          child: Text('PERMITIR'),
          onPressed: () => _bloc.add( AcceptLocationButtonPressed() ),
        ),
      ],
    );
  }

  Widget _contactsPermissionAlert(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15.0) ),
      title: Text('Permiso para acceder a tus contactos'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Se debe tener acceso a tus contactos para que puedas compartir tus códigos generados')
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('RECHAZAR'),
          onPressed: () => _bloc.add( RejectContactsButtonPressed() ),
        ),
        FlatButton(
          child: Text('PERMITIR'),
          onPressed: () => _bloc.add( AcceptContactsButtonPressed() ),
        ),
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

  Widget _signupResultAlert(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15.0) ),
      title: Center(child: Text('¡Registro exitoso!')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon( Icons.check, color: Colors.blue, size: 80.0, ),
          teCobroBotton(
            title: 'ACEPTAR',
            handler: () => Navigator.pushNamed(context, '/create_codi_account')
          ),
        ],
      ),
    );
  }


}
