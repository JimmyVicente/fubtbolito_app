import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/pages/about/aboutPage.dart';
import 'package:futbolito_app/controller/signinController.dart';
import 'package:futbolito_app/pages/perfil/perfilPage.dart';

class DrawerPage extends StatelessWidget{
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
                signinController().clearSesion();
                signinController().verificarLogeado(context);
              },
            )
          ],
        ),
      );
    }
    final _drawer = Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('https://www.britanico.edu.pe/blog/wp-content/uploads/2017/10/vocabulario-ingles-britanico-futbol-800x400.jpg')
                )
            ),
            currentAccountPicture: CircleAvatar(
              child: Text("J",
                style: TextStyle(
                    fontSize: 45.0
                ),
              ),
            ),
            accountName: Text('JIMMY'),
            accountEmail: Text('jimmyvicentel@gmail.com'),
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
    return _drawer;
  }

}
