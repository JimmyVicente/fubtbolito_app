import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/about/aboutPage.dart';
import 'package:futbolito_app/login/loginPage.dart';
import 'package:futbolito_app/complejo/mapaComplejo.dart';
import 'package:futbolito_app/perfil/perfilPage.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    void _closedSession() {
      showDialog(
        context: context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
          content: new Text("Seguro desea Salir"),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true, child: new Text("NO"),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              isDefaultAction: true, child: new Text("Si"),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context)=> loginPage()
                ));
              },
            )
          ],
        ),
      );
    }
    final _appBar=  AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text('FUTBOLITO')
      );
    final _drawer = Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                color: Colors.green
            ),
            currentAccountPicture: CircleAvatar(
              child: Text("J",
                style: TextStyle(
                    fontSize: 45.0
                ),
              ),
            ),
          //  accountName: Text(data['nombres']+data['apellidos']),
          ),
          //LISTA DE CAJON
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Perfil"),
            onTap: (){
              Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context) => perfilPage()
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text("Reservas"),
            onTap: (){
//              Navigator.push(context, new MaterialPageRoute(
//                  builder: (BuildContext context) => contact(data)
//              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text("Complejos"),
            onTap: (){
//              Navigator.push(context, new MaterialPageRoute(
//                  builder: (BuildContext context) => contact(data)
//              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text("Mapa"),
            onTap: (){
              Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context) => MapaComplejo()
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
            _closedSession();
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Salir"),
          )
        ],
      ),
    );

    return SafeArea(
      child: Scaffold(
          appBar: _appBar,
          drawer: _drawer,
          body: Stack(
            children: <Widget>[

            ],
          )
      ),
    );
  }
}