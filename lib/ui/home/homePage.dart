import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futbolito_app/controller/comentarioController.dart';
import 'package:futbolito_app/controller/complejoController.dart';
import 'package:futbolito_app/ui/cancha/canchaPage.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/drawer.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:futbolito_app/ui/globales/ui/hidden_scroll_behavior.dart';
import 'package:futbolito_app/ui/home/complejo/ComplejoCard.dart';

import 'comentario/comentarioMaterial.dart';
import 'mapa/mapaPage.dart';


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

  Future sendSubComentario(Map complejo) async {
    Widgets().showDialogLoading(context);
    var resUserComHecho = await comentarioController().getUserComentario(complejo['id']);
    var response;
    if(resUserComHecho!=null){
      if(complejo['suscripcion']){
        response= await comentarioController()
            .saveUpdateComentario(
            complejo['id'],
            resUserComHecho['comentario'],
            resUserComHecho['puntuacion_usuario'],
            false,
            resUserComHecho
        );
      }else{
        response= await comentarioController()
            .saveUpdateComentario(
            complejo['id'],
            resUserComHecho['comentario'],
            resUserComHecho['puntuacion_usuario'],
            true,
            resUserComHecho
        );
      }
    }else{
      print(resUserComHecho);
      response= await comentarioController()
          .saveUpdateComentario(
          complejo['id'],
          'Comentario generado al sucribirme',
          5,
          true,
          resUserComHecho
      );
    }
    if(response!=null){
      setState(() {
        complejo['suscripcion']=response['suscripcion'];
      });
    }

    Navigator.of(context, rootNavigator: true).pop();
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
                var rowComentario= Container(
                  //padding: EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child:ListTile(
                          title: Icon(
                            Icons.apps,
                            color: Colores.primaryColor,
                          ),
                          subtitle: Widgets.titleStyleinfo('CANCHAS'),
                          onTap: (){
                            Navigator.push(context, CupertinoPageRoute(
                                builder: (BuildContext context)=> CanchaPage(dataComplejos[i])
                            ));
                          },
                        ),
                      ),
                      Expanded(
                        child:ListTile(
                          title: Icon(
                            FontAwesomeIcons.map,
                            color: Colores.primaryColor,
                          ),
                          subtitle: Widgets.titleStyleinfo('MAPA'),
                          onTap: (){
                            OverlayEntry overlayEntry;
                            overlayEntry = OverlayEntry(builder: (c) {
                              return MapaComplejo(dataComplejos[i], onClose: () => overlayEntry.remove());
                            });
                            Overlay.of(context).insert(overlayEntry);
                          },
                        ),
                      ),
                      Expanded(
                        child:ListTile(
                          title: Icon(
                            FontAwesomeIcons.comment,
                            color: Colores.primaryColor,
                          ),
                          subtitle: Widgets.titleStyleinfo('COMENTARIOS'),
                          onTap: (){
                            OverlayEntry overlayEntry;
                            overlayEntry = OverlayEntry(builder: (c) {
                              return Comentario(dataComplejos[i], onClose: () => overlayEntry.remove());
                            });
                            Overlay.of(context).insert(overlayEntry);
                          },
                        ),
                      ),
                      Expanded(
                        child:ListTile(
                          title: dataComplejos[i]['suscripcion']?
                          Icon(
                            Icons.notifications_active,
                            color: Colors.green[900],
                          ):
                          Icon(
                            Icons.notifications,
                            color: Colores.primaryColor,
                          ),
                          subtitle: dataComplejos[i]['suscripcion']?
                          Text(
                            "SUSCRITO",
                            style: TextStyle(
                                color: Colors.green[900],
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            ),
                            textAlign: TextAlign.center,
                          ):
                          Text(
                            "SUSCRIBIRSE",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onTap: (){
                            sendSubComentario(dataComplejos[i]);
                          },
                        ),
                      ),
                    ],
                  ),
                );

                var bodyComplejo= Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Card(
                    child: Column(
                        children: [
                          ComplejoCard(dataComplejos[i]),
                          rowComentario
                        ]
                    ),
                  ),
                );
                return bodyComplejo;
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


