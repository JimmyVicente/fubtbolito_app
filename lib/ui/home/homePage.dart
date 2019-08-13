import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/complejoController.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/drawer.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:futbolito_app/ui/globales/ui/hidden_scroll_behavior.dart';
import 'package:futbolito_app/ui/home/complejo/ComplejoCard.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoadingServices=true;
  var dataComplejos;

  Future _getDataCompeljos()async{
    var response = await complejoController().getCompeljos();
    setState(() {
      dataComplejos = response;
      _isLoadingServices=false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataCompeljos();
  }

  @override
  Widget build(BuildContext context) {
    final _appBar=  AppBar(
        backgroundColor: Colores.primaryColor,
        centerTitle: true,
        title: Text('FUTBOLITO')
    );
    final listComplejos =  Container(
        child: Scrollbar(
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              itemCount: dataComplejos==null ? 0: dataComplejos.length,
              itemBuilder: (BuildContext context, i){
                return ComplejoCard(dataComplejos[i]);
              }
          ),
        )
    );
    var erroInternet=Center(
      child: Text(
        'No hay Coneción a internet :(',
        style: TextStyle(
            color: Colors.white,
            fontSize: 20
        ),
      ),
    );
    return Scaffold(
      appBar: _appBar,
      drawer: DrawerPage.drawer(context),
      body: Stack(
        children: [
          Widgets.wallpaper,
          this._isLoadingServices?Center(child: CircularProgressIndicator(),):
          this.dataComplejos[0]['nombre_complejo']=='-1'?erroInternet :
          SafeArea(
            child: ScrollConfiguration(
                behavior: HiddenScrollBehavior(),
                child: listComplejos
            ),
          ),
        ],
      ),
    );
  }

}


