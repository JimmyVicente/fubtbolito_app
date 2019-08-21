import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/widget.dart';


class MapaComplejo extends StatefulWidget {
  final VoidCallback onClose;
  final data;
  const MapaComplejo(this.data, {this.onClose});
  @override
  State<StatefulWidget> createState() => MapaComplejoState();
}

class MapaComplejoState extends State<MapaComplejo> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimatoin;

  //
  double latitude;
  double longitude;

  cargarCordenadas(){
    String coordenadas= widget.data['coordenadas_complejo'];
    if(coordenadas!=null){
      var arrayCoordenadas=coordenadas.split(',');
      latitude= double.parse(arrayCoordenadas[0]);
      longitude= double.parse(arrayCoordenadas[1]);
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
    cargarCordenadas();
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
          'MAPA',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
    var nullCoor= Center(
      child: Text(
        'No hay Coordenadas para este complejo',
        textAlign: TextAlign.center,
      ),
    );
    return Scaffold(
      backgroundColor:Colors.black.withOpacity(opacityAnimation.value),
      body: ScaleTransition(
        scale: scaleAnimatoin,
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/8),
          decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          child:Container(
            child: Column(
              children: <Widget>[
                appBar,
                Expanded(
                  child: latitude==null?nullCoor:
                  Widgets.GoogleMaps(
                      '${widget.data['nombre_complejo']}',
                      latitude,
                      longitude
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}