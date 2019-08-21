import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futbolito_app/controller/comentarioController.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/widget.dart';

class Comentario extends StatefulWidget {
  final VoidCallback onClose;
  final data;
  const Comentario(this.data, {this.onClose});
  @override
  State<StatefulWidget> createState() => ComentarioState();
}

class ComentarioState extends State<Comentario>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimatoin;

  //
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerComentario = TextEditingController();
  bool _isLoadingServices = true;
  List comentario = [];
  List<Widget> starsBtn;
  int punt = 5;
  bool sub=false;
  Map resUserComHecho=null;

  Future getDataComentario() async {
    resUserComHecho = await comentarioController().getUserComentario(widget.data['id']);
    if(resUserComHecho!=null){
      controllerComentario = TextEditingController(text: resUserComHecho['comentario'].toString());
      punt= resUserComHecho['puntuacion_usuario'];
      starsBtn = [];
      for (int i = 1; i <= 5; i++) {
        if (i <= punt) {
          starsBtn.add(
            starBtnPuntuacion(i, true),
          );
        } else {
          starsBtn.add(
            starBtnPuntuacion(i, false),
          );
        }
      }
      sub=resUserComHecho['suscripcion'];
    }
    var response = await comentarioController().getComentario(widget.data['id']);
    if (response != null) {
      setState(() {
        comentario = response;
        _isLoadingServices = false;
      });
    } else {
      setState(() {
        _isLoadingServices = false;
      });
    }
  }

  Future sendComentario() async {
    if (_formKey.currentState.validate()) {
      Widgets().showDialogLoading(context);
      var response= await comentarioController()
          .saveUpdateComentario(widget.data['id'], controllerComentario.text, punt, sub, resUserComHecho);
      if (response['comentario'] != null) {
        if(response['actualizar']!=null){
          setState(() {
            comentario[0]=response;
          });
        }else{
          setState(() {
            comentario.add(response);
          });
        }

        controllerComentario.clear();
        FocusScope.of(context).requestFocus(new FocusNode());
      }
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    scaleAnimatoin =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    getDataComentario();
    //estrellas
    starsBtn = [];
    for (int i = 0; i < 5; i++) {
      starsBtn.add(
        starBtnPuntuacion(i + 1, true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var appBar = Container(
      height: 60,
      color: Colores.primaryColor,
      child: ListTile(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: widget.onClose),
        title: Text(
          'COMENTARIOS',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
    var nullCom = Center(
      child: Text(
        'Aun no hay Comentarios para este complejo',
        textAlign: TextAlign.center,
      ),
    );
    var listaComentarios = Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child:  comentario.length == 0 ? nullCom
          : ListView.builder(
        shrinkWrap: true,
        itemCount: comentario == null ? 0 : comentario.length,
        itemBuilder: (BuildContext context, int i) {
          if(i==0 && resUserComHecho!=null){
            return comentarioInfo(comentario[i], Colors.red);
          }else{
            return comentarioInfo(comentario[i], Colors.blue);
          }
        },
      ),
    );
    var puntuacion = Container(
      child: Column(
        children: <Widget>[
          Container(
              child:Text(
                'CALIFICA AL COMPLEJO DEPORTIVO',
                style: TextStyle(
                    color: Colors.blue,
                  fontSize: 10
                ),
              )
          ),
          Container(
            margin: EdgeInsets.only(right: 50, left: 50),
            child: Row(
              children: starsBtn,
            ),
          ),
          Container(
            child: InkWell(
             child : Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                Container(
                  child:  sub? Icon(
                    Icons.notifications_active,
                    color: Colors.green,
                    size: 20,
                  ):Icon(
                    Icons.notifications,
                    size: 20,
                  ),
                ),
                 Container(
                   margin: EdgeInsets.only(bottom: 2),
                     child: sub?Text(
                       'SUSCRITO',
                       style: TextStyle(
                           color: Colors.green,
                         fontSize: 10
                       ),
                     ):
                     Text(
                       'SUSCRIBIRSE',
                       style: TextStyle(
                           fontSize: 10
                       ),
                     )
                 )
               ],
             ),
              onTap: (){
                setState(() {
                  if(sub){
                    sub=false;
                  }else{
                    sub=true;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
    var textFielComentario = Container(
      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 2),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: controllerComentario,
          validator: (text) {
            if (text.length == 0) {
              return "Escriba un comentario";
            } else if (text.length <= 3) {
              return "Escriba al menos 4 caracteres";
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                sendComentario();
              },
            ),
          ),
        ),
      ),
    );
    var btnSendComentario = Container(
        child: Column(
          children: <Widget>[puntuacion, textFielComentario],
        ));
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(opacityAnimation.value),
      body: ScaleTransition(
        scale: scaleAnimatoin,
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
          decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          child: this._isLoadingServices ?
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  appBar
                ],
              ),
              Center(child: CircularProgressIndicator())
            ],
          ):
          Column(
            children: <Widget>[
              appBar,
              Expanded(child: listaComentarios),
              btnSendComentario
            ],
          ),
        ),
      ),
    );
  }

  Widget comentarioInfo(Map comentario, Color color) {
    final startPaint = Expanded(
      child: Icon(
        FontAwesomeIcons.solidStar,
        color: Colores.colorYellow,
        size: 15,
      ),
    );
    final startNotPaint = Expanded(
      child: Icon(
        FontAwesomeIcons.star,
        color: Colores.colorYellow,
        size: 15,
      ),
    );
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      if (i < comentario['puntuacion_usuario']) {
        stars.add(startPaint);
      } else {
        stars.add(startNotPaint);
      }
    }
    var puntuacion = Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              comentario['usuario']['first_name'] +' '+comentario['usuario']['last_name'],
              style: TextStyle(color: Colors.white),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: stars),
          Container(
            child: Text(
              comentario['puntuacion_usuario'].toString(),
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
    var bodyComentario = Container(
      child: ListTile(
        title: Text(
          comentario['comentario'],
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          comentario['fecha_creacion'],
          style: TextStyle(color: Colors.grey[50], fontWeight: FontWeight.w100, fontSize: 11),
        ),
      ),
    );
    return Container(
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          gradient: Colores.gradientBlueGreen,
        border: Border.all(color: color, width: 2)
      ),
      margin: EdgeInsets.all(2),
      child: Row(
        children: <Widget>[
          Expanded(
            child: puntuacion,
          ),
          Expanded(
            child: bodyComentario,
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget starBtnPuntuacion(int i, bool activate) {
    return Expanded(
      child: IconButton(
        icon: Icon(
          activate ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star,
          color: Colores.colorYellow,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            punt = i;
            starsBtn = [];
            for (int i = 1; i <= 5; i++) {
              if (i <= punt) {
                starsBtn.add(
                  starBtnPuntuacion(i, true),
                );
              } else {
                starsBtn.add(
                  starBtnPuntuacion(i, false),
                );
              }
            }
          },
          );
        },
      ),
    );
  }
}
