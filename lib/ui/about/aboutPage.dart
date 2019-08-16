import 'package:flutter/material.dart';
import 'package:futbolito_app/ui/globales/colors.dart';

class aboutPage extends StatefulWidget {
  @override
  _aboutPage createState() => _aboutPage();
}

class _aboutPage extends State<aboutPage> {
  @override
  Widget build(BuildContext context) {
    final _appBar=  AppBar(
        title: Text('Acerca de'),
      backgroundColor: Colores.primaryColor,
    );
    final _title= Container(
      padding: EdgeInsets.only(top:40),
      child: Center(
        child: Text('Futbolito', style: TextStyle(fontSize: 50, color: Colors.blueAccent),),
      )
    );
    final _text1 = Container(
        padding: EdgeInsets.only(top:10),
        child: Center(
            child: Text('Desarrollada en Loja-Ecuador por Jimmy Vicente.',
                style: TextStyle(
                    color: Colors.black
                )
            ))
    );

    final _text2 = Container(
        padding: EdgeInsets.only(top:10),
        child: Center(
            child: Text('Tecnologia',
                style: TextStyle(
                    color: Colors.black
                )
            ))
    );

    final _text3 = Container(
        padding: EdgeInsets.only(top:30),
        child: Center(
            child: Text('Todos los derechos reservados. 2019',
                style: TextStyle(
                    color: Colors.black
                )
            ))
    );

    final _text4 = Container(
        padding: EdgeInsets.only(top:20),
        child: Center(
            child: Text('Versión 1.0.0',
                style: TextStyle(
                    color: Colors.black
                )
            ))
    );


    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: _appBar,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            ListView(
              children: <Widget>[
                _title,
                _text1,
                _text2,
                _text3,
                _text4,
              ],
            ),
          ],
        )
    );
  }
}