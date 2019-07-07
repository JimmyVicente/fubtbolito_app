import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/userController.dart';
import 'package:futbolito_app/model/user.dart';
import 'package:futbolito_app/pages/about/aboutPage.dart';
import 'package:futbolito_app/pages/globales/colors.dart';
import 'package:futbolito_app/controller/signinController.dart';
import 'package:futbolito_app/pages/perfil/perfilPage.dart';
import 'package:futbolito_app/pages/signin/ui/blur_background.dart';
import 'package:futbolito_app/pages/signin/ui/hidden_scroll_behavior.dart';

class EventPage extends StatefulWidget {
  @override
  _eventPageState createState() => _eventPageState();
}

class _eventPageState extends State<EventPage> {

  var user;

  @override
  void initState() {
    super.initState();
    user=User.user;
  }

  @override
  Widget build(BuildContext context) {
    final _appBar=  AppBar(
        backgroundColor: Colores.primaryColor,
        centerTitle: true,
        title: Text('NOTICIAS')
    );
    return Scaffold(
      appBar: _appBar,
      drawer: _drawer(),
      body: Stack(
        children: [
          BlurBackground(
            assetImage: 'assets/images/trees.jpg',
            backDropColor: Colors.black.withOpacity(0.5),
            blurX: 0.5,
            blurY: 0.5,
          ),
          Center(
            child: ScrollConfiguration(
              behavior: HiddenScrollBehavior(),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(20),
                children: [

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawer(){
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
                    image: AssetImage('assets/images/trees.jpg'),
                    fit: BoxFit.cover
                )
            ),
            currentAccountPicture: CircleAvatar(
              child: Text(user['first_name'][0],
                style: TextStyle(
                    fontSize: 45.0
                ),
              ),
            ),
            accountName: Text(user['first_name']+ ' '+ user['last_name']),
            accountEmail: Text(user['email']),
          ),
          //LISTA DE CAJON
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


