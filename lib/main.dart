import 'package:flutter/material.dart';
import 'package:futbolito_app/ui/signin/signin.dart';
import 'package:futbolito_app/ui/splashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inicio de sesión',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      routes: {
        '/':(context)=> SplashScreen(),
        '/signin':(context)=> SignInPageWidget(),
      },
    );
  }
}

