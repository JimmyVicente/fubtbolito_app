import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/model/user.dart';
import 'package:futbolito_app/ui/about/aboutPage.dart';
import 'package:futbolito_app/controller/signinController.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:futbolito_app/ui/perfil/perfilPage.dart';


class DrawerPage {


 static Widget drawer(BuildContext context) {
    closedSession(){
      signinController().clearSesion();
      Navigator.of(context).pushReplacementNamed('/siging');
    }
    exitApp(){
      exit(0);
    }
    final _drawer = Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/trees.jpg'),
                    fit: BoxFit.cover
                )
            ),
            currentAccountPicture: CircleAvatar(
              child: Text(User.first_name[0],
                style: TextStyle(
                    fontSize: 45.0
                ),
              ),
            ),
            accountName: Text(User.first_name+ ' '+ User.last_name),
            accountEmail: Text(User.email),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Perfil"),
            onTap: (){
              Navigator.push(context, CupertinoPageRoute(
                  builder: (BuildContext context) => perfilPage()
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("Acerca de"),
            onTap: (){
              Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context) => aboutPage()
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.close),
            title: Text("Cerrar sesión"),
            onTap: (){
              Widgets().showAlert(context, 'Seguro desea cerrar Sesión', closedSession);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Salir"),
            onTap: (){
              Widgets().showAlert(context, 'Seguro desea salir', exitApp);
            },
          )
        ],
      ),
    );
    return _drawer;
  }



}


