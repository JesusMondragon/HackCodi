import 'package:flutter/material.dart';
import 'package:tecobro/pages/create_codi_account.dart';
import 'pages/create_bank_account.dart';
import 'pages/password_reset.dart';
import 'pages/signin.dart';
import 'pages/signup.dart';

Map<int, Color> color =
{
50:Color.fromRGBO(136,14,79, .1),
100:Color.fromRGBO(136,14,79, .2),
200:Color.fromRGBO(136,14,79, .3),
300:Color.fromRGBO(136,14,79, .4),
400:Color.fromRGBO(136,14,79, .5),
500:Color.fromRGBO(136,14,79, .6),
600:Color.fromRGBO(136,14,79, .7),
700:Color.fromRGBO(136,14,79, .8),
800:Color.fromRGBO(136,14,79, .9),
900:Color.fromRGBO(136,14,79, 1),
};

class App extends StatelessWidget {
  final Color mainColor = Color(0xffb74093);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Te Cobro',
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => Signin(),
        '/password_reset': (context) => PasswordReset(),
        '/signup': (context) => Signup(),
        '/create_codi_account': (context) => CreateCodiAccount(),
        '/create_bank_account':(context) => CreateBankAccount(),
      },
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF5130bb, color)
      ),
    );
  }
}