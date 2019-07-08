import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/complejoController.dart';
import 'package:futbolito_app/model/user.dart';
import 'package:futbolito_app/ui/cancha/canchaPage.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/drawer.dart';
import 'package:futbolito_app/ui/signin/ui/blur_background.dart';
import 'package:futbolito_app/ui/signin/ui/hidden_scroll_behavior.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoadingServices=true;

  var dataComplejos;
  Future _getData()async{
    var response = await complejoController().getCompeljos();
    setState(() {
      dataComplejos = response;
      _isLoadingServices=false;
    });
  }

  var user;

  @override
  void initState() {
    super.initState();
    user=User.user;
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final _appBar=  AppBar(
        backgroundColor: Colores.primaryColor,
        centerTitle: true,
        title: Text('FUTBOLITO')
    );
    final listComplejos =  Container(
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(20),
          itemCount: dataComplejos==null ? 0: dataComplejos.length,
          itemBuilder: (BuildContext context, i){
            return new  Container(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: Colores.secondGradient
                    ),
                    child: ListTile(
                      title: Center(child: Text(dataComplejos[i]['nombre_complejo'])),
                      subtitle: Center(child: Text(dataComplejos[i]['telefono_complejo']),),
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(
                            builder: (BuildContext context)=> CanchaPage(dataComplejos[i])
                        ));
                      },
                    )
                )
            );
          }
      ),
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
          BlurBackground(
            assetImage: 'assets/images/home.jpg',
            backDropColor: Colors.black.withOpacity(0.1),
          ),
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


