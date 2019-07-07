import 'package:flutter/material.dart';
import 'package:futbolito_app/pages/home/bottomNavigation.dart';
import 'package:futbolito_app/pages/signin/signin.dart';
import 'package:futbolito_app/pages/splashScreen.dart';

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
        '/home':(contex)=> BottomNavigation()
      },
    );
  }
}

