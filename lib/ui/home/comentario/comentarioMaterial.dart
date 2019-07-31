import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ComentarioMaterial {
  void verComentario(BuildContext context) {
    List comentarios=null;
    var nullCom= Center(
      child: Text(
        'Aun no hay Comentarios para este complejo',
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
        title: "Comentarios",
        content: Container(
          height: MediaQuery.of(context).size.height*0.6,
          child: Column(
            children: <Widget>[
              comentarios==null?nullCom:
              Text('HOLA')
            ],
          )
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

  }
}


