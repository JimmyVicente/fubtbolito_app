import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futbolito_app/controller/signinController.dart';
import 'package:futbolito_app/controller/signupController.dart';
import 'package:futbolito_app/ui/globales/ui/blur_background.dart';
import 'package:futbolito_app/ui/globales/ui/hidden_scroll_behavior.dart';
import 'package:futbolito_app/ui/globales/widget.dart';


class SignUpPageWidget extends StatefulWidget {
  @override
  _SignUpPageWidgetState createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerFirstName = new TextEditingController();
  TextEditingController controllerLastname = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  RegExp emailRegExp = new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  bool passwordObscureText=true;
  String mensaje="";

  void _goToSignIn(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Color textFieldActiveColor = Colors.white;
    Color textFieldInactiveColor = Colors.grey;

    var firstNameField = Container(
      padding: EdgeInsets.only(right: 7),
      child: TextFormField(
        cursorColor: textFieldActiveColor,
        style: TextStyle(color: textFieldActiveColor),
        controller: controllerFirstName,
        validator: (text) {
          if (text.length == 0) {
            return "Escriba sus nombres";
          } else if (text.length <= 3) {
            return "Escriba al menos 4 caracteres";
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textFieldInactiveColor),
          ),
          labelText: "Nombres",
          labelStyle: TextStyle(color: textFieldActiveColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textFieldActiveColor),
          ),
        ),
        autocorrect: false,
      ),
    );
    var lastNameField = Container(
      padding: EdgeInsets.only(left: 7),
      child: TextFormField(
        cursorColor: textFieldActiveColor,
        style: TextStyle(color: textFieldActiveColor),
        controller: controllerLastname,
        validator: (text) {
          if (text.length == 0) {
            return "Escriba sus apellidos";
          } else if (text.length <= 3) {
            return "Escriba al menos 4 caracteres";
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textFieldInactiveColor),
          ),
          labelText: "Apellidos",
          labelStyle: TextStyle(color: textFieldActiveColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textFieldActiveColor),
          ),
        ),
        autocorrect: false,
      ),
    );
    var emailField = Container(
      child: TextFormField(
        cursorColor: textFieldActiveColor,
        style: TextStyle(color: textFieldActiveColor),
        controller: controllerEmail,
        validator: (text) {
          if (text.length == 0) {
            return "Escriba su correo";
          } else if (text.length <= 3) {
            return "Escriba al menos 4 caracteres";
          }else if(!emailRegExp.hasMatch(text)){
            return "Escriba un correo valido";
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textFieldInactiveColor),
          ),
          labelText: "Correo",
          labelStyle: TextStyle(color: textFieldActiveColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textFieldActiveColor),
          ),
        ),
        autocorrect: false,
      ),
    );
    var userField = Container(
      child: TextFormField(
        cursorColor: textFieldActiveColor,
        style: TextStyle(color: textFieldActiveColor),
        controller: controllerUser,
        validator: (text) {
          if (text.length == 0) {
            return "Escriba un usuario";
          } else if (text.length <= 3) {
            return "Escriba al menos 4 caracteres";
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textFieldInactiveColor),
          ),
          labelText: "Usuario",
          labelStyle: TextStyle(color: textFieldActiveColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textFieldActiveColor),
          ),
        ),
        autocorrect: false,
      ),
    );
    var passwordField = Container(
      child: TextFormField(
        controller: controllerPassword,
        validator: (text) {
          if (text.length == 0) {
            return "Escriba una contraseña";
          } else if (text.length <= 3) {
            return "Escriba al menos 4 caracteres";
          }
          return null;
        },
        cursorColor: textFieldActiveColor,
        style: TextStyle(color: textFieldActiveColor),
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: textFieldInactiveColor)),
            labelText: "Contraseña",
            labelStyle:TextStyle(color: textFieldActiveColor),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: textFieldActiveColor),
            ),
            suffixIcon:IconButton(
                icon: this.passwordObscureText?Icon(FontAwesomeIcons.eye):Icon(FontAwesomeIcons.eyeSlash),
                onPressed: (){
                  setState(() {
                    if(passwordObscureText){
                      passwordObscureText=false;
                    }else{
                      passwordObscureText=true;
                    }
                  });
                }
            )
        ),
        obscureText: passwordObscureText,
      ),
    );
    var textFormFiel=Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: firstNameField),
                Expanded(child: lastNameField)
              ],
            ),
            emailField,
            userField,
            passwordField
          ],
        ),
      ),
    );
    var errorMessage=Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Text(mensaje, style: TextStyle(color: Colors.red),)
    );
    var signUpButton = Container(
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
          "Regístrate",
          textAlign: TextAlign.center,
        ),
        onPressed: () async{
          if (_formKey.currentState.validate()) {
            Widgets().showDialogLoading(context);
            final response = await registerController().postSignup(
                controllerFirstName.text,
                controllerLastname.text,
                controllerUser.text,
                controllerEmail.text,
                controllerPassword.text
            );
            if(response=='registrado'){
              final responseSignin = await signinController().verificarInicio(controllerUser.text, controllerPassword.text);
              if(responseSignin['url'] != null){
                Navigator.pop(context);
                signinController().verificarLogeado(context);
              }
            }else {
              setState(() {
                mensaje = response.toString();
              });
            }
            Navigator.of(context, rootNavigator: true).pop();
          }
        },
      ),
    );

    var alreadyHaveAnAccount = Container(
      margin: EdgeInsets.only(top: 26),
      height: 17,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "¿Ya tienes una cuenta? ",
                style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 12
                ),
              ),
            ),
          ),
          Expanded(
              child:  Container(
                alignment: Alignment.centerLeft,
                child:FlatButton(
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  textColor: Colors.white,
                  onPressed: () => _goToSignIn(context),
                ),
              )
          )
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:Stack(
        children: [
          BlurBackground(
            assetImage: 'assets/images/trees.jpg',
            backDropColor: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: ScrollConfiguration(
              behavior: HiddenScrollBehavior(),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(20),
                children: [
                  textFormFiel,
                  errorMessage,
                  signUpButton,
                  alreadyHaveAnAccount
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
