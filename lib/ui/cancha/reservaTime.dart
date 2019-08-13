import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/reservaController.dart';

class reservaTime extends StatefulWidget {
  reservaTime(this.idCancha);
  final idCancha;
  @override
  _reservaTimeState createState() => _reservaTimeState();
}



class _reservaTimeState extends State<reservaTime> {
  Future getDataReserva() async {
    var response = await reservaController().getReservaIdCancha(widget.idCancha);
    print(response);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('hola'),
    );
  }
}
