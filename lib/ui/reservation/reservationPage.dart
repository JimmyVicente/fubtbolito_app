import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/reservaController.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/drawer.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:futbolito_app/ui/reservation/reservationMadePage.dart';
import 'package:futbolito_app/ui/globales/ui/hidden_scroll_behavior.dart';

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  List reserva = [];
  bool _isLoadingServices = true;

  Future loadData() async {
    var response = await reservaController().getReservaUser();
    if (response[0]['usuario'] != '-1') {
      setState(() {
        reserva = response;
        _isLoadingServices=false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
        backgroundColor: Colores.primaryColor,
        centerTitle: true,
        title: Text('RESERVAS'));
    final btnReservationMade = Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      height: 17,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "¿Ya tienes reservas? ",
                style: TextStyle(color: Colores.primaryColor, fontSize: 12),
              ),
            ),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            child: FlatButton(
                child: Text(
                  'Historial',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                textColor: Colores.primaryColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (BuildContext context) =>
                              ReservationMadePage()));
                }),
          ))
        ],
      ),
    );
    var listaReserva = Container(
      child: ScrollConfiguration(
        behavior: HiddenScrollBehavior(),
        child: _isLoadingServices?Center(child: CircularProgressIndicator(),):
        ListView.builder(
          shrinkWrap: true,
          itemCount: reserva == null ? 0 : reserva.length,
          padding: EdgeInsets.all(20),
          itemBuilder: (BuildContext context, int i) {
            return reservationMade(reserva[i]);
          },
        ),
      ),
    );
    return Scaffold(
      appBar: _appBar,
      drawer: DrawerPage.drawer(context),
      body: Stack(
        children: [Widgets.wallpaper, listaReserva],
      ),
    );
  }

  Widget reservationMade(Map data) {
    final iconButtomActions = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
            icon: Icon(
              CupertinoIcons.create,
              color: Colors.white,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              CupertinoIcons.delete,
              color: Colors.white,
            ),
            onPressed: () {})
      ],
    );

    final container = Container(
        padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                data['fecha_reserva'],
                style: TextStyle(color: Colores.primaryColor, fontSize: 15),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 1),
                  child: Icon(
                    CupertinoIcons.collections,
                    color: Colores.primaryColor,
                    size: 15,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Text(
                    data['fecha_reserva'],
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 1),
                  child: Icon(
                    CupertinoIcons.time,
                    color: Colores.primaryColor,
                    size: 15,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Text(
                    data['hora_inicio'],
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 1),
                  child: Icon(
                    CupertinoIcons.time,
                    color: Colores.primaryColor,
                    size: 15,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Text(
                    data['hora_fin'],
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 1),
                  child: Icon(
                    Icons.monetization_on,
                    color: Colores.primaryColor,
                    size: 15,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    data['valor_unitario'],
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 1, left: 2),
                  child: Icon(
                    Icons.monetization_on,
                    color: Colores.primaryColor,
                    size: 15,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    data['valor_total'],
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            )
          ],
        ));

    return InkWell(
      child: Container(
        padding: EdgeInsets.only(bottom: 12),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://concepto.de/wp-content/uploads/2015/02/futbol-1-e1550783405750.jpg'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.35), BlendMode.luminosity),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: <Widget>[iconButtomActions, container],
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
