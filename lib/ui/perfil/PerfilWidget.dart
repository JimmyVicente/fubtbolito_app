import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/userController.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PerfilWidget{

  showCambiarPerfil(BuildContext context, Map user){
    TextEditingController controllerPassword1= TextEditingController();
    TextEditingController controllerPassword2= TextEditingController();
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
        title: "Editar Contraseña",
        style: alertStyle,
        content: Column(
          children: <Widget>[
            TextField(
              controller: controllerPassword1,
             // obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Contraseña Actual',
              ),
            ),
            TextField(
              controller: controllerPassword2,
              //obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Nueva Contraseña',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.of(context,rootNavigator: true).pop(),
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            child: Text(
              "Aceptar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () async{
              var response= await userController().putDataUser(user, controllerPassword1.text, controllerPassword2.text);
              if(response=='editado'){
                Navigator.of(context,rootNavigator: true).pop();
                showEditSuccess(context);
              }
            },
          )
        ]).show();
  }

  showEditSuccess(BuildContext context){
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.red,
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: 'Ok',
      desc: "Se modificó correctamente",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();

  }


}