import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:futbolito_app/data/base_api.dart';
import 'package:futbolito_app/home/homePage.dart';
import 'package:futbolito_app/login/loginController.dart';


class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _formKeyUser = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  TextEditingController controladorUsuario = new TextEditingController();
  TextEditingController controladorClave = new TextEditingController();
  bool _isLoadingServices = false;

  String mensaje="";

  Future<List> verificarInicio() async{
    setState(() {
      _isLoadingServices = true;
    });
    BaseApi _baseApi = new BaseApi();
    var usuario=controladorUsuario.text; //variable captura el usuario escrito
    var contrasenia=controladorClave.text; //variable captura la contraseña escrito

    if(usuario=='admin' && contrasenia=='admin'){
      setState(() {
        _isLoadingServices = false;
      });
      Navigator.push(context, new MaterialPageRoute(
          builder: (BuildContext context) => HomePage()
      ));
    }else{
      setState(() {
        _isLoadingServices = false;
        mensaje = 'Usuario o clave incorrecta';
      });

    }
  }
  //DISEÑO
  @override
  Widget build(BuildContext context) {
    void initState(){
      _isLoadingServices = false;
    }

    final _perfilImage = Container(
      padding: EdgeInsets.only(top:40),
      child: new CircleAvatar(
          backgroundColor: Color(0xF81F7F3),
          child: Icon(Icons.account_circle, size: 100,)
      ), //CircleAvatar
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle
      ),
    );

    final _textFieldUser = Container(
      padding: EdgeInsets.only(top: 50, left: 50, right: 50, bottom: 4 ),
      child: Form(
        key: _formKeyUser,
        child: TextFormField(
          controller: controladorUsuario,
          style: TextStyle(
              fontSize: 20
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Escriba un usuario';
            }
          },
          decoration: InputDecoration(
            hintText: 'Usuario/Correo',
          ),
        ),
      )
    );

    final _textFieldPassword = Container(
      padding: EdgeInsets.only(top: 10, left: 50, right: 50,bottom: 4),
      child: Form(
        key: _formKeyPassword,
        child: TextFormField(
          controller: controladorClave,
          style: TextStyle(
              fontSize: 20
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Escriba una contraseña';
            }
          },
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Contraseña'
          ),
        ),
      )
    );

    final _texto = Container(
        padding: EdgeInsets.only(top: 4, left: 50, right: 50,bottom: 4),
        child: Text(mensaje, style: TextStyle(color: Colors.red),)
    );

    final _buttonIniciar = Container(
      width: 250.0,
      height: 60,
      padding: EdgeInsets.only(top: 9.0, right: 50, left: 50),
      child: new RaisedButton(
        child: new Text(
            "INICIAR SESIÓN",
            style: new TextStyle(
                color: Colors.white,
                fontSize: 20
            )
        ),
        colorBrightness: Brightness.dark,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20.0),
        ), //RoundedRectangleBorder
        onPressed:() {
          if (_formKeyUser.currentState.validate() && _formKeyPassword.currentState.validate()) {
            verificarInicio();
          }
        },
        color: Colors.green,
      ),
    );
    final _buttonOlvide = Container(
      child: ListTile(
        title: Text("OLVIDÉ MI CONTRASEÑA", style: TextStyle(color: Colors.grey),),
        contentPadding: EdgeInsets.only(left: 115),
        onTap: (){
//          Navigator.push(context, new MaterialPageRoute(
//              builder: (BuildContext context) => recoveryPassword()
//          ));
        },
      ),
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              this._isLoadingServices
                  ? Center(
                child: CircularProgressIndicator(),
              ):
              _perfilImage,
              _textFieldUser,
              _textFieldPassword,
              _texto,
              _buttonIniciar,
              _buttonOlvide
            ],
          )
        ],
      )
    ); //Scaffold
  }
}
