import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futbolito_app/ui/cancha/canchaPage.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/home/comentario/comentarioMaterial.dart';
import 'package:futbolito_app/ui/home/mapa/mapaPage.dart';

class ComplejoCard extends StatelessWidget {
  final dataComplejo;
  ComplejoCard(this.dataComplejo);
  @override
  Widget build(BuildContext context) {
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
      if(i<dataComplejo['puntuacion_complejo']){
        stars.add(startPaint);
      }else{
        stars.add(startNotPaint);
      }
    }
    final _TitleComplejo=Container(
      child: Text(dataComplejo['nombre_complejo'],
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colores.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
    );
    final puntuacion =Container(
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
            child: Text(dataComplejo['telefono_complejo'], style: TextStyle(color: Colors.white, fontSize: 10),),
          ),
        ],
      ),
    );
    final _Adress = Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(
                CupertinoIcons.location,
                color: Colores.primaryColor,
                size: 15,
              ),
            ),
            Container(
              child: Text(
                dataComplejo['direccion_complejo'],
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ],
        )
    );
    final image=Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.blue),
          gradient: Colores.primaryGradient,
          image: dataComplejo['foto_complejo']!=null?
          DecorationImage(
              image: NetworkImage(dataComplejo['foto_complejo'].toString()),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
          ):
          DecorationImage(
              image: AssetImage('assets/images/trees.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
          )
      ),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _TitleComplejo,
              puntuacion,
              _Phone,
              _Adress
            ],
          ),
        ],
      ),
    );

    return InkWell(
      child: image,
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(
            builder: (BuildContext context)=> CanchaPage(dataComplejo)
        ));
      },
    );
  }
}



