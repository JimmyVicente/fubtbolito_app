import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/comentarioController.dart';
import 'package:futbolito_app/ui/globales/colors.dart';

class Comentario extends StatefulWidget {
  final VoidCallback onClose;
  final data;
  const Comentario(this.data, {this.onClose});
  @override
  State<StatefulWidget> createState() => ComentarioState();
}

class ComentarioState extends State<Comentario> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimatoin;

  //
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerComentario= TextEditingController();
  bool _isLoadingServices=true;
  List comentario=[];

  Future getDataComentario()async{
    var response = await comentarioController().getComentario(widget.data['id']);
    if(response!=null){
      setState(() {
        comentario = response;
        _isLoadingServices=false;
      });
    }else{
      setState(() {
        _isLoadingServices=false;
      });
    }
  }

  Future sendComentario() async{
    if (_formKey.currentState.validate()) {
      var response = await comentarioController().postComentario(
          widget.data['id'],
          controllerComentario.text
      );
      if(response['comentario'] != null){
        setState(() {
          comentario.add(response);
        });
        controllerComentario.clear();
        FocusScope.of(context).requestFocus(new FocusNode());
      }
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
  }

  @override
  Widget build(BuildContext context) {
    final appBar=  Container(
      height: 60,
      color: Colores.primaryColor,
      child: ListTile(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: widget.onClose
        ),
        title: Text(
        'COMENTARIOS',
        style: TextStyle(
            color: Colors.white
        ),
      ),
      ),
    );
    var nullCom= Center(
      child: Text(
        'Aun no hay Comentarios para este complejo',
        textAlign: TextAlign.center,
      ),
    );
    var listaComentarios= Container(
      padding: EdgeInsets.all(20),
      child: this._isLoadingServices?Center(child: CircularProgressIndicator(),):
      comentario.length==0?nullCom:
      ListView.builder(
        shrinkWrap: true,
        itemCount: comentario==null?0:comentario.length,
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            title: Text(comentario[i]['comentario']),
          );
        },
      ),
    );
    var btnSendComentario=Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.bottomCenter,
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
                onPressed: (){
                  sendComentario();
                },
              )
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor:Colors.black.withOpacity(opacityAnimation.value),
      body: ScaleTransition(
        scale: scaleAnimatoin,
        child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
              child:Column(
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
}


