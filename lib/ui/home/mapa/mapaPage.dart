import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../homePage.dart';


class mapaAlert {

  void verMapa(Map data, BuildContext context) {
    double latitude;
    double longitude;
    String coordenadas= data['coordenadas_complejo'];
    if(coordenadas!=null){
      var arrayCoordenadas=coordenadas.split(',');
      latitude= double.parse(arrayCoordenadas[0]);
      longitude= double.parse(arrayCoordenadas[1]);
    }

    var nullCoor= Center(
      child: Text(
          'No hay Coordenadas para este complejo',
        textAlign: TextAlign.center,
      ),
    );
    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 200),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colores.primaryColor,
      ),
    );
    Alert(
        context: context,
        style: alertStyle,
        title: "Mapa",
        content: Stack(
          children: <Widget>[
            latitude==null?nullCoor:
            Container(
              height: MediaQuery.of(context).size.height/2*0.6,
              child: Widgets.GoogleMaps(
                  '${data['nombre_complejo']}',
                  latitude,
                  longitude
              ),
            )
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: Text(
              "CERRAR",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
//    Navigator.push(context, PageRouteBuilder(
//        opaque: false,
//        pageBuilder: (BuildContext context, _, __) {
//          return mapaPage(data);
//        },
//        transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
//          return FadeTransition(
//            opacity: animation,
//            child: RotationTransition(
//              turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
//              child: child,
//            ),
//          );
//        }
//    ));
  }
}
