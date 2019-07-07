import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:futbolito_app/controller/signinController.dart';
import 'package:futbolito_app/pages/home/bottomNavigation.dart';
import 'package:futbolito_app/pages/signin/ui/blur_background.dart';
import 'package:futbolito_app/pages/signin/ui/hidden_scroll_behavior.dart';
import 'package:futbolito_app/pages/signup/signup.dart';

import 'forgot_password.dart';

class SignInPageWidget extends StatefulWidget {
  @override
  _SignInPageWidgetState createState() => _SignInPageWidgetState();
}

class _SignInPageWidgetState extends State<SignInPageWidget> with signinController{

  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  bool passwordObscureText=true;

  String mensaje="";


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color textFieldActiveColor = Colors.white;
    Color textFieldInactiveColor = Colors.grey;

    var emailField = Container(
        child: TextFormField(
          controller: controllerUser,
          validator: (username) {
            if (username.length == 0) {
              return "Escriba un usuario o correo";
            } else if(username.length <=3){
              return 'Escriba al menos 4 caracteres';
            }
            return null;
          },
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

    var formTextFiel=Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            emailField,
            passwordField,
          ],
        ),
      )
    );
    var errorMessage=Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Text(mensaje, style: TextStyle(color: Colors.red),)
    );
    var signInButton = Container(
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
          "Iniciar Sesión",
          textAlign: TextAlign.center,
        ),
        onPressed: () async{
          if (_formKey.currentState.validate()) {
            final response = await verificarInicio(controllerUser.text, controllerPassword.text);
            if(response == true){
              verificarLogeado(context);
            }else{
              setState(() {
                mensaje = response;
              });
            }
          }
        },
      ),
    );

    var forgotPassword = Container(
      height: 16,
      margin: EdgeInsets.only(top: 18),
      child: FlatButton(
        onPressed: (){
          Navigator.push(context, CupertinoPageRoute(
              builder: (context) => ForgotPasswordPageWidget()),
          );
        },
        textColor: Colors.white,
        padding: EdgeInsets.all(0),
        child: Text(
          "Olvidé contraseña ?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
    var firstSignInSeparator = Container(
      height: 17,
      margin: EdgeInsets.only(top: 36),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Iniciar sesión con",
                style: TextStyle(color: Colors.grey[300],),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 80,
                height: 1,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 75,
                      height: 1,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    var facebookSignInButton = Container(
      width: 300,
      height: 50,
      margin: EdgeInsets.only(right: 10, top: 20),
      child: FlatButton.icon(
        icon: Icon(FontAwesomeIcons.facebook),
        onPressed: () {},
        label: Text('Facebook'),
        color: Color.fromARGB(255, 37, 71, 155),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        textColor: Colors.white,
      )
    );
    var googleSignInButton = Container(
      width: 300,
      height: 50,
      margin: EdgeInsets.only(left: 10, top: 20),
      child: FlatButton.icon(
        icon: Icon(FontAwesomeIcons.google),
        label: Text('Google'),
        onPressed: () {},
        color: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        textColor: Colors.white,
      ),
    );
    var SignInButton = Container(
      child: Row(
        children: <Widget>[
          Expanded(child: facebookSignInButton,),
          Expanded(child: googleSignInButton)
        ],
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
                "¿No tienes una cuenta?",
                style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 12
                ),
              ),
            )
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                  child: Text(
                    'Regístrate',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  textColor: Colors.white,
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(
                        builder: (context) => SignUpPageWidget()),
                    );
                  }
              ),
            )
          )
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
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
                  formTextFiel,
                  errorMessage,
                  signInButton,
                  forgotPassword,
                  firstSignInSeparator,
                  SignInButton,
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


