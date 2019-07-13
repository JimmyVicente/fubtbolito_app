import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/reservaController.dart';
import 'package:futbolito_app/model/user.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/drawer.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:futbolito_app/ui/reservation/reservationMadePage.dart';
import 'package:futbolito_app/ui/signin/ui/blur_background.dart';
import 'package:futbolito_app/ui/signin/ui/hidden_scroll_behavior.dart';

import '../f.dart';

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {

  @override
  Widget build(BuildContext context) {
    final _appBar=  AppBar(
        backgroundColor: Colores.primaryColor,
        centerTitle: true,
        title: Text('RESERVAS')
    );
    final btn= Container(
      margin: EdgeInsets.only(top: 20),
      child: RaisedButton(
        child: Text('VISTA DE TABLA'),
        onPressed: (){
          Navigator.push(context, CupertinoPageRoute(
              builder: (BuildContext context)=> DataTableDemo()
          ));
        },
      ),
    );
    final btnReservationMade=Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      height: 17,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "¿Ya tienes reservas? ",
                style: TextStyle(
                    color: Colores.primaryColor,
                    fontSize: 12
                ),
              ),
            ),
          ),
          Expanded(
              child:  Container(
                alignment: Alignment.centerLeft,
                child:FlatButton(
                  child: Text(
                    'Historial',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  textColor: Colores.primaryColor,
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(
                        builder: (BuildContext context)=> ReservationMadePage()
                    ));
                  }
                ),
              )
          )
        ],
      ),
    );
    return Scaffold(
      appBar: _appBar,
      drawer: DrawerPage.drawer(context),
      body: Stack(
        children: [
          Widgets.wallpaper,
          SafeArea(
            child: ScrollConfiguration(
              behavior: HiddenScrollBehavior(),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(20),
                children: [
                  btnReservationMade,
                  reservationMade(
                      'https://www.britanico.edu.pe/blog/wp-content/uploads/2017/10/vocabulario-ingles-britanico-futbol-800x400.jpg',
                      'Complejo Deportivo GOLAZO',
                      '2019-07-03',
                      '20h30',
                      'Cabildo Municipio de Loja'
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget reservationMade(String image, String _title, String _date, String _hour, String _direccion){
    final _IconButtomActions =Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
            icon: Icon(CupertinoIcons.create, color: Colors.white,),
            onPressed: (){}
        ),
        IconButton(
            icon: Icon(CupertinoIcons.delete, color: Colors.white,),
            onPressed: (){}
        )
      ],
    );

    final _Container= Container(
        padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'EVENTOS PÚBLICOS',
                style: TextStyle(
                    color: Colores.primaryColor,
                    fontWeight: FontWeight.w100,
                    fontSize: 12),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(_title,style: TextStyle(color: Colores.primaryColor, fontSize: 15),),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 1),
                  child: Icon(CupertinoIcons.collections, color: Colores.primaryColor, size: 15,),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Text(_date, style: TextStyle(color: Colors.white, fontSize: 10),),
                ),
                Container(
                  margin: EdgeInsets.only(right: 1),
                  child: Icon(CupertinoIcons.time, color: Colores.primaryColor, size: 15,),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Text(_hour, style: TextStyle(color: Colors.white, fontSize: 10),),
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
                        child: Text(_direccion, style: TextStyle(color: Colors.white, fontSize: 10),),
                      )
                    ],
                  ),
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
              _IconButtomActions,
              _Container
            ],
          ),
        ),
      ),
      onTap: (){

      },
    );
  }
}



