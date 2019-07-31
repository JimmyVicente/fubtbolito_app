import 'package:flutter/material.dart';
import 'package:futbolito_app/ui/globales/ui/blur_background.dart';
import 'package:futbolito_app/ui/globales/ui/hidden_scroll_behavior.dart';
class ForgotPasswordPageWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Color textFieldActiveColor = Colors.white;
    Color textFieldInactiveColor = Colors.grey;
    
    var emailField = Container(
      margin: EdgeInsets.symmetric(vertical: 27.5),
      child: TextField(
        cursorColor: textFieldActiveColor,
        style: TextStyle(color: textFieldActiveColor),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textFieldInactiveColor),
          ),
          labelText: "Usuario/Correo",
          labelStyle: TextStyle(color: textFieldActiveColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textFieldActiveColor),
          ),
        ),
        autocorrect: false,
      ),
    );
    var forgotPasswordButton = Container(
      height: 55,
      child: FlatButton(
        onPressed: () {},
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(27.5),
          ),
        ),
        textColor: Colors.deepOrange,
        padding: EdgeInsets.all(0),
        child: Text(
          "Recuperar Contraseña",
          textAlign: TextAlign.center,
        ),
      ),
    );
    var dontHaveAnAccount = Container(
      margin: EdgeInsets.only(top: 26),
      height: 17,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "¿No necesitó recuperar? ",
                style: TextStyle(color: Colors.grey[300]),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                child: Text(
                  'Regresar',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                textColor: Colors.white,
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          BlurBackground(
            assetImage: 'assets/images/trees.jpg',
            backDropColor: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: ScrollConfiguration(
              behavior: HiddenScrollBehavior(),
              child: ListView(
                padding: EdgeInsets.all(20.0),
                shrinkWrap: true,
                children: <Widget>[
                  Image.asset(
                    'assets/images/olvide.png',
                    height: 80,
                    width: 80,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 27.5),
                    child: Text(
                      'Ingrese su usuario o correo electrónico y\n haga clic en el botón Recuperar Contraseña',
                      style: TextStyle(color: Colors.grey[300]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  emailField,
                  forgotPasswordButton,
                  dontHaveAnAccount
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
