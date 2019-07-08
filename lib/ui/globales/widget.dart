import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class Widgets  {
  void showAlert(BuildContext context, String title, Function function) {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        content: new Text(title),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true, child: new Text("NO"),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true, child: new Text("Si"),
            onPressed: (){
              Navigator.pop(context);
              function();
            },
          )
        ],
      ),
    );
  }

  showDialogLoading(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Column(
              children: <Widget>[
                Text('Espere..', textAlign: TextAlign.center, style: TextStyle(color: Colores.primaryColor),),
                Divider(color: Colores.primaryColor,),
              ],
            ),
            children: <Widget>[
              SimpleDialogOption(
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator()
                    ],
                  )
              ),
            ],
          );
        });
  }

  void showDialogInfo(BuildContext context, String title, String body, Function function) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Column(
              children: <Widget>[
                Text(title, textAlign: TextAlign.center, style: TextStyle(color: Colores.primaryColor),),
                Divider(color: Colores.primaryColor,),
              ],
            ),
            children: <Widget>[
              SimpleDialogOption(
                  child: Column(
                    children: <Widget>[
                      Text(body,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300
                        ),
                      )
                    ],
                  )
              ),
              SimpleDialogOption(
                child: RaisedButton(
                  child: Text('ACEPTAR', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18),),
                  color: Colores.primaryColor,
                  onPressed: (){
                    function();
                  },
                ),
              )
            ],
          );
        });
  }

}


