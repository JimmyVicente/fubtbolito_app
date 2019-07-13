import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/complejoController.dart';
import 'package:futbolito_app/model/user.dart';
import 'package:futbolito_app/ui/cancha/canchaPage.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/drawer.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:futbolito_app/ui/signin/ui/blur_background.dart';
import 'package:futbolito_app/ui/signin/ui/hidden_scroll_behavior.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoadingServices=true;

  var dataComplejos;
  Future _getDataCompeljos()async{
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
    _getDataCompeljos();
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
            return Complejo(
                'https://www.britanico.edu.pe/blog/wp-content/uploads/2017/10/vocabulario-ingles-britanico-futbol-800x400.jpg',
                dataComplejos[i]
            );
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
      drawer: DrawerPage.drawer(context),
      body: Stack(
        children: [
          Widgets.wallpaper,
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
  Widget Complejo(String image, Map data){


    final start= Expanded(
      child: Icon(
        Icons.star,
        color: Colores.colorStart,
      ),
    );
    final _puntuacion =Container(
      margin: EdgeInsets.only(left: 50, right: 50),
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          start,start,start,start,start
        ],
      ),
    );

    final _Container= Container(
        padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(data['nombre_complejo'],style: TextStyle(color: Colores.primaryColor, fontSize: 15),),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 1),
                  child: Icon(CupertinoIcons.phone, color: Colores.primaryColor, size: 15,),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Text(data['telefono_complejo'], style: TextStyle(color: Colors.white, fontSize: 10),),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 1),
                  child: Icon(CupertinoIcons.location, color: Colores.primaryColor, size: 15,),
                ),
                Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(data['direccion_complejo'], style: TextStyle(color: Colors.white, fontSize: 10),),
                        )
                      ],
                    )
                )
              ],
            )
          ],
        )
    );

    return InkWell(
      child: Container(
        padding: EdgeInsets.only(bottom: 12),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.35), BlendMode.luminosity),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: <Widget>[
              _puntuacion,
              _Container
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(
            builder: (BuildContext context)=> CanchaPage(data,'https://www.britanico.edu.pe/blog/wp-content/uploads/2017/10/vocabulario-ingles-britanico-futbol-800x400.jpg')
        ));
      },
    );
  }
}


