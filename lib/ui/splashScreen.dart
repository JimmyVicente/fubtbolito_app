import 'dart:async';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/signinController.dart';
import 'package:futbolito_app/controller/userController.dart';
import 'package:futbolito_app/model/user.dart';
import 'package:futbolito_app/ui/globales/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with signinController{
  Timer _timer;
  Future<void> getUser()async{
    var dataUserpersistence = await signinController().loadSesion();
    if(dataUserpersistence !=null){
      var dataUser = await userController().getDataUser();
      setState(() {
        User.user = dataUser;
      });
    }
    verificarLogeado(context);
  }

  @override
  void initState() {
    super.initState();
     getUser();
   // _timer = Timer(const Duration(milliseconds: 800), _onShowLogin);

  }

//  @override
//  void dispose() {
//    _timer.cancel();
//    super.dispose();
//  }

  void _onShowLogin() {
    if(mounted){
      verificarLogeado(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colores.primaryColor
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('BIENVENIDO A FUTBOLITO' ,style: TextStyle(color: Colors.white),),
            ],
          )
        )
      ),
    );
  }

}
