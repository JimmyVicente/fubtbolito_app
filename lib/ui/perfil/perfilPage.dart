import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:futbolito_app/ui/globales/ui/hidden_scroll_behavior.dart';

import 'PerfilWidget.dart';

class perfilPage extends StatefulWidget {
  final userPercistence;
  perfilPage(this.userPercistence);

  @override
  _perfilPage createState() => _perfilPage();
}

class _perfilPage extends State<perfilPage> {

  @override
  Widget build(BuildContext context) {
    final _image= Container(
        height: 210,
        width: MediaQuery.of(context).size.width,
        decoration:  BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/trees.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.luminosity)
            )
        ),
        child: Stack(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white,),
                  onPressed: (){
                    Navigator.pop(context);
                  }
              ),
            ]
        )
    );
    var imagePerfil =Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only( top: 120),
      child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.green[500], width: 2),
            color: Colors.blue
          ),
          padding: EdgeInsets.all(2),
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            backgroundImage: AssetImage('assets/images/user.png'),
          ),
      ),
    );

    var nameUser= Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        widget.userPercistence['first_name']+' '+widget.userPercistence['last_name'],
        style: TextStyle(color: Colores.primaryColor,
            fontSize: 30
        ),
        textAlign: TextAlign.center,
      ),
    );
    var usernameUser= Container(
      margin: EdgeInsets.only(top: 1),
      child: Text(
        widget.userPercistence['username'],
        style: TextStyle(
            color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      ),
    );
    var emailUser= Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        widget.userPercistence['email'],
        style: TextStyle(color: Colors.blue),
        textAlign: TextAlign.center,
      ),
    );
    var btnEdit= Container(
      margin: EdgeInsets.only(top: 10),
      child: RaisedButton.icon(
          icon: Icon(Icons.edit),
          label: Text('Editar Perfil'),
          onPressed: (){
            _editPerfil();
          }
      ),
    );
    var _body =Container(
        padding: EdgeInsets.only(right: 10, left: 10, top: 180 , bottom: 10),
        child: Card(
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(top:20),
              child: Column(
                children: <Widget>[
                  nameUser,
                  emailUser,
                  usernameUser,
                  btnEdit
                ],
              ),
            )
        )
    );

    return Scaffold(
        body: SafeArea(
          child: Stack(
              children: [
                Widgets.wallpaper,
                Column(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          _image,
                          _body,
                          imagePerfil,
                        ],
                      ),
                    ),
                  ],
                ),
              ]
          ),
        )
    );
  }

  void _editPerfil() {
    PerfilWidget().showCambiarPerfil(context, widget.userPercistence);
  }
}
