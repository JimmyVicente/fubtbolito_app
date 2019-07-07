import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/complejoController.dart';
import 'package:futbolito_app/controller/userController.dart';
import 'package:futbolito_app/model/user.dart';
import 'package:futbolito_app/pages/about/aboutPage.dart';
import 'package:futbolito_app/pages/cancha/canchaPage.dart';
import 'package:futbolito_app/pages/globales/colors.dart';
import 'package:futbolito_app/controller/signinController.dart';
import 'package:futbolito_app/pages/globales/widget.dart';
import 'package:futbolito_app/pages/perfil/perfilPage.dart';
import 'package:futbolito_app/pages/signin/ui/blur_background.dart';
import 'package:futbolito_app/pages/signin/ui/hidden_scroll_behavior.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoadingServices=true;

  var dataComplejos;
  Future _getData()async{
    var response = await complejoController().getCompeljos();
    setState(() {
      dataComplejos = response;
      _isLoadingServices=false;
    });
  }

  var user;

  @override
  void initState() {
    super.initState();
    user=User.user;
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final _appBar=  AppBar(
        backgroundColor: Colores.primaryColor,
        centerTitle: true,
        title: Text('FUTBOLITO')
    );
    final listComplejos =  Container(
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(20),
          itemCount: dataComplejos==null ? 0: dataComplejos.length,
          itemBuilder: (BuildContext context, i){
            return new  Container(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: Colores.secondGradient
                    ),
                    child: ListTile(
                      title: Center(child: Text(dataComplejos[i]['nombre_complejo'])),
                      subtitle: Center(child: Text(dataComplejos[i]['telefono_complejo']),),
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(
                            builder: (BuildContext context)=> CanchaPage(dataComplejos[i])
                        ));
                      },
                    )
                )
            ); //Container
          }
      ),
    );
    var erroInternet=Center(
      child: Text(
        'No hay Coneción a internet :(',
        style: TextStyle(
            color: Colors.white,
            fontSize: 20
        ),
      ),
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
          this._isLoadingServices?Center(child: CircularProgressIndicator(),):
              this.dataComplejos[0]['nombre_complejo']=='-1'?erroInternet :
          SafeArea(
            child: ScrollConfiguration(
              behavior: HiddenScrollBehavior(),
              child: listComplejos
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawer(){
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
              Wiggets().showAlert(context, 'Seguro desea cerrar Sesión', closedSession);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Salir"),
            onTap: (){
              Wiggets().showAlert(context, 'Seguro desea salir', exitApp);
            },
          )
        ],
      ),
    );
    return _drawer;
  }

  void closedSession(){
    signinController().clearSesion();
    signinController().verificarLogeado(context);
  }

  void exitApp(){
    exit(0);
  }

}


