import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:futbolito_app/data/base_api.dart';
import 'package:futbolito_app/home/homePage.dart';

class perfilPage extends StatefulWidget {
  @override
  _perfilPage createState() => _perfilPage();
}

class _perfilPage extends State<perfilPage> {
  final _formKeyPasswordActual = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  TextEditingController controladorPasswordActual = new TextEditingController();
  TextEditingController controladorPassword = new TextEditingController();
  bool _isLoadingServices = false;

  void _verRespuesta(String mensaje,) {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        content: new Text(mensaje),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true, child: new Text("Aceptar"),
            onPressed: (){
              Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context)=> perfilPage()
              ));
            },
          ),
        ],
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    final _textFieldPasswordActual = Container(
        padding: EdgeInsets.only(top: 10, left: 30, right:30,bottom: 4),
        child: Form(
          key: _formKeyPasswordActual,
          child: TextFormField(
            controller: controladorPasswordActual,
            style: TextStyle(
                fontSize: 20
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Escriba la contraseña actual';
              }
            },
            obscureText: true,
            decoration: InputDecoration(
                hintText: 'Contraseña Actual'
            ),
          ),
        )
    );
    final _textFieldPassword = Container(
        padding: EdgeInsets.only(top: 10, left: 30, right: 30,bottom: 4),
        child: Form(
          key: _formKeyPassword,
          child: TextFormField(
            controller: controladorPassword,
            style: TextStyle(
                fontSize: 20
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Escriba una contraseña nueva';
              }
            },
            obscureText: true,
            decoration: InputDecoration(
                hintText: 'Contraseña nueva'
            ),
          ),
        )
    );
    final _buttonCancelar= Container(
      padding: EdgeInsets.only(left: 30,bottom: 4),
      child: RaisedButton(
        child: new Text('Cancelar', style: TextStyle(color: Colors.white),),
        color: Colors.green,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)
        ),
        onPressed: (){
          Navigator.push(context, new MaterialPageRoute(
              builder: (BuildContext context)=> perfilPage()
          ));
        },
      ),
    );

    final _buttonCambiar = Container(
      child: RaisedButton(
        child: new Text('Aceptar', style: TextStyle(color: Colors.white),),
        color: Colors.green,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)
        ),
        onPressed: (){
          if (_formKeyPasswordActual.currentState.validate() && _formKeyPassword.currentState.validate()) {

          }
        },
      ),
    );

    void _changePassword() {
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: Text('CAMBIO DE CONTRASEÑA'),
              children: <Widget>[
                this._isLoadingServices
                    ? Center(
                  child: CircularProgressIndicator(),
                ):
                SimpleDialogOption(
                    child: _textFieldPasswordActual
                ),
                SimpleDialogOption(
                    child: _textFieldPassword
                ),
                Row(
                  children: <Widget>[
                    SimpleDialogOption(
                        child: _buttonCancelar
                    ),
                    SimpleDialogOption(
                        child: _buttonCambiar
                    )
                  ],
                ),
              ],
            );
          });
    }

    final _appBar=  AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()
              ));
            }
        ),
        title: Text('Perfil')
    );
    
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
    final _name = Container(
      padding: EdgeInsets.only(top:55),
      child: Center(
//        child: Text(data['nombres']+data['apellidos'],
//            style: TextStyle(
//                color: Colors.black
//            )
//        )
      )
    );
    
    final _email = Container(
        padding: EdgeInsets.only(top:10, bottom:40 ),
        child: Center(
//          child: Text(data['correo'],
//              style: TextStyle(
//                  color: Colors.black
//              )),
        )
    );

    final _button = Container(
      padding: EdgeInsets.only(top: 10),
      child: RaisedButton(
        child: new Text('CAMBIAR CONTRASEÑA', style: TextStyle(color: Colors.white),),
        color: Colors.green,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)
        ),
        onPressed: (){
          _changePassword();
        },
      ),
    );
    
    final _info = Container(
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(

        border: Border.all(color: Colors.black26)
      ),
      child: Column(
        children: <Widget>[
//          Container(
//            padding: EdgeInsets.only(top: 10),
//            child: Text("Cedula:  "+data['cedula']),
//          ),
//          Container(
//            padding: EdgeInsets.only(top: 10),
//            child: Text("Celular:  "+data['celular']),
//          ),
          _button
        ],
      ),
    );
    

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: _appBar,
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                _perfilImage,
                _name,
                _email,
                _info
              ],
            )
          ],
        )
    );
  }
}
