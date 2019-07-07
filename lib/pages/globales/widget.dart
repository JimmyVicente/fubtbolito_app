import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wiggets  {

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
              function();
            },
          )
        ],
      ),
    );
  }

}


