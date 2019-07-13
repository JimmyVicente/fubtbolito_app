import 'package:flutter/material.dart';


class Colores {
  static final primaryColor = Color.fromRGBO(14, 171, 128,1) ;
  static final primaryLightColor =Color.fromRGBO(172, 236, 100,1) ;
  static final colorStart= Color.fromRGBO(248, 216, 3, 1) ;
  static final primaryTextColor = Color.fromRGBO(0, 34, 73,0);
  static final colorAccent= Color.fromRGBO(0, 34, 73,0);
  static final colorFondo= Color.fromRGBO(0, 34, 73,0);
  static final appBar= Color.fromRGBO(0, 34, 73,0);
  static final colorBlanco= Color.fromRGBO(0, 34, 73,0);
  static final colorNegro= Color.fromRGBO(0, 34, 73,0);
  static final colorAzul= Color.fromRGBO(0, 34, 73,1);
  static final colorGris= Color.fromRGBO(0, 34, 73,0);

  //Gradientes
  static final primaryGradient= LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [-0.4, 0.2, 0.7, 0.6],
    colors: [
      Colors.green[100]..withOpacity(0.8),
      Colors.green[200].withOpacity(0.8),
      Colors.green[800].withOpacity(0.8),
      Colors.green[800].withOpacity(0.8),
    ],
  );
  static final secondGradient= LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [-0.4, 0.2, 0.7, 0.6],
    colors: [
      Colors.blue[100]..withOpacity(0.8),
      Colors.blue[200].withOpacity(0.8),
      Colors.blue[800].withOpacity(0.8),
      Colors.blue[800].withOpacity(0.8),
    ],
  );


}
