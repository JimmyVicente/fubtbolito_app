import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/userController.dart';
import 'package:futbolito_app/ui/globales/Alerts.dart';
import 'package:futbolito_app/ui/globales/ui/blur_background.dart';
import 'package:futbolito_app/ui/globales/ui/hidden_scroll_behavior.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgotPasswordPageWidget extends StatefulWidget {
  @override
  _ForgotPasswordPageWidgetState createState() => _ForgotPasswordPageWidgetState();
}


class _ForgotPasswordPageWidgetState extends State<ForgotPasswordPageWidget> {
  final _formKey = GlobalKey<FormState>();
  String mensaje="";
  TextEditingController controllerUser = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Color textFieldActiveColor = Colors.white;
    Color textFieldInactiveColor = Colors.grey;
    var errorMessage=Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Text(mensaje, style: TextStyle(color: Colors.red),)
    );
    var emailField = Container(
      margin: EdgeInsets.symmetric(vertical: 27.5),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: controllerUser,
          cursorColor: textFieldActiveColor,
          style: TextStyle(color: textFieldActiveColor),
          validator: (text) {
            if (text.length == 0) {
              return "Escriba un usuario o correo";
            } else if (text.length <= 3) {
              return "Escriba al menos 4 caracteres";
            }
            return null;
          },
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
      )
    );
    var forgotPasswordButton = Container(
      height: 55,
      child: FlatButton(
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
        onPressed: () async{
          if (_formKey.currentState.validate()) {
            Widgets().showDialogLoading(context);
           var response= await userController().sendCorreo(controllerUser.text);
           Navigator.of(context, rootNavigator: true).pop();
           if(response=='enviado'){
             AlertWidget().showEditSuccessRegresar(context, 'Se envió una contraseña temporal a tu correo electrónico, Recuerdad cambiar la contraseña para mas seguridad');
           }else{
             setState(() {
               mensaje = response.toString();
             });
           }
          }
        },
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
                  errorMessage,
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
