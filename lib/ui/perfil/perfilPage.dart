import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:futbolito_app/controller/userController.dart';
import 'package:futbolito_app/model/user.dart';
import 'package:futbolito_app/ui/globales/Alerts.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'PerfilWidget.dart';

class perfilPage extends StatefulWidget {
  @override
  _perfilPage createState() => _perfilPage();
}

class _perfilPage extends State<perfilPage> {
  String names=User.first_name+' '+User.last_name;
  showEditPasswor() async{
    PerfilWidget().showEditPasswor(context);
  }
  showEditNames(BuildContext context){
    TextEditingController controllerFirstName= TextEditingController(text: User.first_name);
    TextEditingController controllerlastName= TextEditingController(text: User.last_name);
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
                    controller: controllerFirstName,
                    validator: (text) {
                      if (text.length == 0) {
                        return "Escriba la contraseña actual";
                      } else if (text.length <= 3) {
                        return "Escriba al menos 4 caracteres";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Nombres',
                    ),
                  ),
                  TextFormField(
                    controller: controllerlastName,
                    validator: (text) {
                      if (text.length == 0) {
                        return "Escriba la contraseña actual";
                      } else if (text.length <= 3) {
                        return "Escriba al menos 4 caracteres";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Apellidos',
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
                var response= await userController().putDataUserNames(
                    controllerFirstName.text,
                    controllerlastName.text
                );
                if(response['url']!=null){
                  Navigator.of(context,rootNavigator: true).pop();
                  Navigator.of(context,rootNavigator: true).pop();
                  AlertWidget().showEditSuccess(context, "Se modificó correctamente");
                  setState(() {
                    names=response['first_name']+" "+ response['last_name'];
                  });
                }
              }
            },
          )
        ]).show();
  }
  @override
  Widget build(BuildContext context) {
    var image= Container(
        height: 210,
        width: MediaQuery.of(context).size.width,
        decoration:  BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/trees.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.luminosity)
            )
        ),
        child: Stack(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white,),
                  onPressed: (){
                    Navigator.pop(context);
                  }
              ),
            ]
        )
    );
    var imagePerfil =Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only( top: 120),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.green[500], width: 2),
            color: Colors.blue
        ),
        padding: EdgeInsets.all(2),
        child: CircleAvatar(
          backgroundColor: Colors.blue,
          backgroundImage: AssetImage('assets/images/user.png'),
        ),
      ),
    );
    var nameUser= Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            names,
            style: TextStyle(color: Colores.primaryColor,
                fontSize: 30
            ),
            textAlign: TextAlign.center,
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){
              showEditNames(context);
            },
          )
        ],
      )
    );
    var usernameUser= Container(
      margin: EdgeInsets.only(top: 1),
      child: Text(
        User.username,
        style: TextStyle(
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      ),
    );
    var emailUser= Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        User.email,
        style: TextStyle(color: Colors.blue),
        textAlign: TextAlign.center,
      ),
    );
    var btnEditPass= Container(
      margin: EdgeInsets.only(top: 10),
      child: RaisedButton.icon(
          icon: Icon(Icons.edit),
          label: Text('Editar Contraseña'),
          onPressed: (){
            showEditPasswor();
          }
      ),
    );
    var body =Container(
        padding: EdgeInsets.only(right: 10, left: 10, top: 180 , bottom: 10),
        child: Card(
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(top:20),
              child: Column(
                children: <Widget>[
                  nameUser,
                  emailUser,
                  usernameUser,
                  btnEditPass
                ],
              ),
            )
        )
    );

    return Scaffold(
        body: SafeArea(
          child: Stack(
              children: [
                Widgets.wallpaper,
                Column(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          image,
                          body,
                          imagePerfil,
                        ],
                      ),
                    ),
                  ],
                ),
              ]
          ),
        )
    );
  }
}
