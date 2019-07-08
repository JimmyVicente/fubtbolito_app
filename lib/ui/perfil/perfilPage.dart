import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:futbolito_app/model/user.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/signin/ui/blur_background.dart';
import 'package:futbolito_app/ui/signin/ui/hidden_scroll_behavior.dart';

class perfilPage extends StatefulWidget {
  @override
  _perfilPage createState() => _perfilPage();
}

class _perfilPage extends State<perfilPage> {
  
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
        title: Text('PERFIL')
    );
    var imagePerfil =Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          gradient: Colores.primaryGradient,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colores.primaryColor),
        ),
        child: Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/user.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(50)
          ),
        )
    );

 

    var ColumnStyle=Container(
        child: Column(
          children: <Widget>[
            imagePerfil,
            Container(
              margin: EdgeInsets.only(top: 27.5),
              child: Text(
                user['email'],
                style: TextStyle(color: Colors.grey[300]),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
    );
 
    var signInButton = Container(
      height: 55,
      child: FlatButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(27.5),
          ),
        ),
        textColor: Colors.deepOrange,
        padding: EdgeInsets.all(0),
        child: Text(
          "Iniciar Sesión",
          textAlign: TextAlign.center,
        ),
        onPressed: () async{

        },
      ),
    );

    var forgotPassword = Container(
      height: 16,
      margin: EdgeInsets.only(top: 18),
      child: FlatButton(
        onPressed: (){

        },
        textColor: Colors.white,
        padding: EdgeInsets.all(0),
        child: Text(
          "Olvidé contraseña ?",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );



    var dontHaveAnAccount = Container(
      margin: EdgeInsets.only(top: 26),
      height: 17,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "¿No tienes una cuenta?",
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 12
                  ),
                ),
              )
          ),
          Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: FlatButton(
                    child: Text(
                      'Regístrate',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    textColor: Colors.white,
                    onPressed: (){

                    }
                ),
              )
          )
        ],
      ),
    );

    return Scaffold(
      appBar: _appBar,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BlurBackground(
            assetImage: 'assets/images/home.jpg',
            backDropColor: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: ScrollConfiguration(
              behavior: HiddenScrollBehavior(),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(20),
                children: [
                  ColumnStyle,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
