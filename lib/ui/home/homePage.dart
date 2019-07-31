import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futbolito_app/controller/complejoController.dart';
import 'package:futbolito_app/ui/cancha/canchaPage.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/drawer.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:futbolito_app/ui/globales/ui/hidden_scroll_behavior.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'comentario/comentarioMaterial.dart';
import 'comentario/f.dart';
import 'mapa/mapaPage.dart';

class HomePage extends StatefulWidget {
  final userPercistence;
  HomePage(this.userPercistence);
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
                return Complejo(dataComplejos[i]);
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
      drawer: DrawerPage.drawer(context, widget.userPercistence),
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
  Widget Complejo(Map data){
    final startPaint= Expanded(
      child: Icon(
        FontAwesomeIcons.solidStar,
        color: Colores.colorYellow,
        size: 15,
      ),
    );
    final startNotPaint= Expanded(
      child: Icon(
        FontAwesomeIcons.star,
        color: Colores.colorYellow,
        size: 15,
      ),
    );
    List<Widget> stars=[];
    for(int i=0; i<5; i++){
      if(i<data['puntuacion_complejo']){
        stars.add(startPaint);
      }else{
        stars.add(startNotPaint);
      }
    }

    final _TitleComplejo=Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(data['nombre_complejo'],
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colores.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
    );

    final _puntuacion =Container(
      margin: EdgeInsets.only(top: 10, right: 50, left: 50),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: stars
      ),
    );

    final _Phone= Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 1),
            child: Icon(CupertinoIcons.phone, color: Colores.primaryColor, size: 15,),
          ),
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Text(data['telefono_complejo'], style: TextStyle(color: Colors.white, fontSize: 10),),
          ),
        ],
      ),
    );

    final _Adress=Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 1),
            child: Icon(CupertinoIcons.location, color: Colores.primaryColor, size: 15,),
          ),
          Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(data['direccion_complejo'], style: TextStyle(color: Colors.white, fontSize: 10),),
                  )
                ],
              )
          )
        ],
      ),
    );
    final _Container= Container(
        padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _TitleComplejo,
            _puntuacion,
            _Phone,
            _Adress
          ],
        )
    );

    final _Image=Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: data['foto_complejo']!=null? BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.blue),
            gradient: Colores.primaryGradient,
            image: DecorationImage(
                image: NetworkImage(data['foto_complejo'].toString()),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
            )
        ):
        BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.blue),
            image: DecorationImage(
                image: AssetImage('assets/images/trees.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
            )
        ),
      child: _Container,
    );



    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      backgroundColor: Colors.green,
      child: Container(
        height: MediaQuery.of(context).size.width*1.7,
        width: MediaQuery.of(context).size.width/2*0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:  EdgeInsets.all(15.0),
              child: Text('Cool', style: TextStyle(color: Colors.red),),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Awesome', style: TextStyle(color: Colors.red),),
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            FlatButton(onPressed: (){
              Navigator.of(context, rootNavigator: true).pop();
            },
                child: Text('Got It!', style: TextStyle(color: Colors.purple, fontSize: 18.0),))
          ],
        ),
      ),
    );


    var rowComentario= Container(
      padding: EdgeInsets.only(right: 50, left: 50),
      child: Row(
        children: <Widget>[
          Expanded(
              child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.locationArrow,
                    color: Colores.primaryColor,
                  ),
                  onPressed: (){
                    mapaAlert().verMapa(data, context);
                  }
              )
          ),
          Expanded(
            child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.comment,
                  color: Colores.primaryColor,
                ),
                onPressed: (){
                  ComentarioMaterial().verComentario(context);
                }
            ),

          ),
          Expanded(
              child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.solidStickyNote,
                    color: Colores.primaryColor,
                  ),
                  focusColor: Colors.green,
                  onPressed: (){
                    showDialog(context: context, builder: (BuildContext context) => errorDialog);
                    //Navigator.of(context).push(TutorialOverlay());
//                    Navigator.of(context)
//                        .overlay
//                        .insert(OverlayEntry(builder: (BuildContext context) {
//                      return FunkyOverlay();
//                    }));
                  }
              )
          ),
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Card(
        child: Column(
            children: [
              InkWell(
                child: _Image,
                onTap: (){
                  Navigator.push(context, CupertinoPageRoute(
                      builder: (BuildContext context)=> CanchaPage(widget.userPercistence,data)
                  ));
                },
              ),
              rowComentario
            ]
        ),
      ),
    );
  }




}


