import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/reservaController.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:futbolito_app/ui/globales/ui/hidden_scroll_behavior.dart';

class ReservationMadePage extends StatefulWidget {
  @override
  _ReservationMadePageState createState() => _ReservationMadePageState();
}

class _ReservationMadePageState extends State<ReservationMadePage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appBar=  AppBar(
        backgroundColor: Colores.primaryColor,
        centerTitle: true,
        title: Text('HISTORIAL',)
    );
    final Fute = FutureBuilder(
      future: loadData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return tablaReserva(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    return Scaffold(
      appBar: _appBar,
      body: Stack(
        children: [
          Widgets.wallpaper,
          SafeArea(
            child: ScrollConfiguration(
              behavior: HiddenScrollBehavior(),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(20),
                children: [
                  titleTable('Reservas', Colores.primaryColor),
                  Fute,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tablaReserva(Map data){
    return Container(
      child: Table(
        border: TableBorder(
          top: BorderSide(color: Colores.primaryColor),
          bottom: BorderSide(color: Colores.primaryColor),
          horizontalInside: BorderSide(color: Colores.primaryColor),
        ),
        defaultColumnWidth: FractionColumnWidth(0.1),
        children: [
          TableRow(
              decoration: BoxDecoration(
                  gradient: Colores.primaryGradient
              ),
              children: [
                rowTitleTable('FECHA'),
                rowTitleTable('CANCHA'),
                rowTitleTable('HORA ENTRADA'),
                rowTitleTable('HORA SALIDA'),
                rowTitleTable('VALOR UNITARIO'),
                rowTitleTable('VALOR TOTAL'),
              ]),
          TableRow(
              children: [
                rowBodyTable(data['fecha_reserva'].toString()),
                rowBodyTable(data['cancha'].toString()),
                rowBodyTable(data['hora_inicio'].toString()),
                rowBodyTable(data['hora_fin'].toString()),
                rowBodyTable(data['valor_unitario'].toString()),
                rowBodyTable(data['valor_total'].toString()),
              ]
          ),
        ],
      ),
    );
  }



  Widget rowTitleTable(String data){
    return Container(
        margin: EdgeInsets.all(1.0),
        child: Text(data,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        )
    );
  }
  Widget rowBodyTable(String data){
    return Container(
        margin: EdgeInsets.all(1.0),
        child: Text(data,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 10,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        )
    );
  }
  Widget titleTable(String title, Color color){
    return Container(
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
            color: color
        ),
      ),
    );
  }
  Future<Map> loadData() async {
    var response = await reservaController().getReservaUser();
    return response[0];
  }
}
