import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_codi_app/blocs/signup/bloc.dart';

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

          if(state is ChangingTCCheckBox) {
            return _signupForm(context, state.newValue);
          }

          if(state is DownloadingTC) {
            return Center(child: CircularProgressIndicator());
          }

          if(state is ShowingTC) {
            return ListView(
              padding: EdgeInsets.all(15.0),
              children: <Widget>[
                Text("Terminos y Condiciones."),
                Text(state.tc),
                RaisedButton(
                  child: Text('Aceptar'),
                  onPressed: () => _bloc.add(AcceptTCButtonPressed() ),
                ),
              ],
            );
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
                RaisedButton(
                  child: Text('Reintentar'),
                  onPressed: () => _bloc.add(RetryButtonPressed()),
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
        
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
            Checkbox(
              value: tcCheckboxValue,
              onChanged: (valor) => _bloc.add(TCCheckBoxChanged(value: valor)),
            ),
            Text("Aceptar"),
            FlatButton(
              onPressed: () => _bloc.add(TermsAndConditionsButtonPressed()),
              child: Text(
                "términos y condiciones",
                style: TextStyle(decoration: TextDecoration.underline)
              ),
            )
          ],
        ),

        RaisedButton(
          child: Text('Registrarme'),
          padding: EdgeInsets.symmetric(horizontal: 150.0),
          onPressed: () => _bloc.add(RegisterButtonPressed(
            email: _emailController.text,
            password: _passwordController.text
          )),
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
          FlatButton(
            child: Text('ACEPTAR'),
            onPressed: () => Navigator.pushNamed(context, '/create_account'),
          ),
        ],
      ),
    );
  }


}
