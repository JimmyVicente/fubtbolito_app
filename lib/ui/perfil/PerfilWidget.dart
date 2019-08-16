import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/userController.dart';
import 'package:futbolito_app/ui/globales/Alerts.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PerfilWidget {

  showEditPasswor(BuildContext context){
    TextEditingController controllerPassword1= TextEditingController();
    TextEditingController controllerPassword2= TextEditingController();
    TextEditingController controllerPassword3= TextEditingController();
    final _formKey = GlobalKey<FormState>();
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
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: controllerPassword1,
                    obscureText: true,
                    validator: (text) {
                      if (text.length == 0) {
                        return "Escriba la contraseña actual";
                      } else if (text.length <= 3) {
                        return "Escriba al menos 4 caracteres";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Contraseña Actual',
                    ),
                  ),
                  TextFormField(
                    controller: controllerPassword2,
                    validator: (text) {
                      if (text.length == 0) {
                        return "Escriba la contraseña actual";
                      } else if (text.length <= 3) {
                        return "Escriba al menos 4 caracteres";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Nueva Contraseña',
                    ),
                  ),
                  TextFormField(
                    controller: controllerPassword3,
                    validator: (text) {
                      if (text.length == 0) {
                        return "Confirme contraseña";
                      } else if (text.length <= 3) {
                        return "Escriba al menos 4 caracteres";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Confirmar Contraseña',
                    ),
                  ),
                ],
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
              if (_formKey.currentState.validate()) {
                Widgets().showDialogLoading(context);
                var response= await userController().putDataUserPassword(
                    controllerPassword1.text,
                    controllerPassword2.text,
                  controllerPassword3.text,
                );
                Navigator.of(context,rootNavigator: true).pop();
                if(response!=null){
                  Navigator.of(context,rootNavigator: true).pop();
                  AlertWidget().showEditSuccess(context, "Se modificó correctamente");
                }else{

                }
              }
            },
          )
        ]).show();
  }
}