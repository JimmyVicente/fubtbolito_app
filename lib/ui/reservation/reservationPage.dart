import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futbolito_app/controller/reservaController.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/drawer.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:futbolito_app/ui/home/mapa/mapaPage.dart';
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
    var response= await reservaController().getReservaUser();
    setState(() {
      reserva = response;
      _isLoadingServices=false;
    });
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
    var erroInternet=Center(
      child: Text(
        'No hay Conexión a internet :(',
        style: TextStyle(
            color: Colors.white,
            fontSize: 20
        ),
      ),
    );
    var nullReservas=Center(
      child: Text(
        'No ha registro de reservas',
        style: TextStyle(
            color: Colors.white,
            fontSize: 20
        ),
      ),
    );
    var listaReserva = Container(
      child: ScrollConfiguration(
        behavior: HiddenScrollBehavior(),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: reserva == null ? 0 : reserva.length,
          padding: EdgeInsets.all(20),
          itemBuilder: (BuildContext context, int i) {
            return reservaMode(reserva[i]);
          },
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
          this.reserva[0]['usuario']=='-1'?erroInternet :
          this.reserva[0]['usuario']=='-2'?nullReservas :
          listaReserva
        ],
      ),
    );
  }

  Widget reservaMode(Map data){
    var iconButtomActions = Row(
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
    var titleComplejo=Container(
      child: Text(data['complejo']['nombre_complejo'],
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colores.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
    );
    var titleCancha =Container(
      margin: EdgeInsets.only(top: 2, right: 50, left: 50),
      child:Column(
        children: <Widget>[
          Widgets.titleStyleinfo('CANCHA RESERVADA'),
          Container(
            child: Text(data['cancha']['descripcion_cancha'],
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
              ),
            ),
          )
        ],
      )
    );
    var date= Container(
        margin: EdgeInsets.only(right: 10),
        child: Column(
          children: <Widget>[
            Widgets.titleStyleinfo('FECHA DE ASISTENCIA'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 1),
                  child: Icon(
                    FontAwesomeIcons.calendarAlt,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 2),
                  child: Text(
                    data['fecha_reserva'],
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
          ],
        )
    );
    var timeStart= Container(
      margin: EdgeInsets.only(right: 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 2),
            child: Widgets.titleStyleinfo('HORA INICO'),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 1),
                child: Icon(
                  FontAwesomeIcons.clock,
                  color: Colors.white,
                  size: 15,
                ),
              ),
              Container(
                child: Text(
                  data['hora_inicio'],
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          )
        ],
      ),
    );
    var timeEnd= Container(
      margin: EdgeInsets.only(right: 10),
      child: Column(
        children: <Widget>[
          Container(
            child: Widgets.titleStyleinfo('HORA FINALIZACIÓN'),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 1),
                child: Icon(
                  FontAwesomeIcons.clock,
                  color: Colors.white,
                  size: 15,
                ),
              ),
              Container(
                child: Text(
                  data['hora_fin'],
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          )
        ],
      )
    );
    var dateTime = Container(
        margin: EdgeInsets.only(top: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            date,
            timeStart,
            timeEnd,
          ],
        )
    );
    var valorUnitario= Container(
      margin: EdgeInsets.only(right: 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 2),
            child: Widgets.titleStyleinfo('VALOR UNITARIO'),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 1),
                child: Icon(
                  Icons.monetization_on,
                  color: Colors.white,
                  size: 15,
                ),
              ),
              Container(
                child: Text(
                  data['valor_unitario'],
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          )
        ],
      ),
    );
    var valorTotal= Container(
        margin: EdgeInsets.only(right: 10),
        child: Column(
          children: <Widget>[
            Container(
              child: Widgets.titleStyleinfo('VALOR TOTAL'),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 1),
                  child: Icon(
                    Icons.monetization_on,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
                Container(
                  child: Text(
                    data['valor_total'],
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            )
          ],
        )
    );
    var valor = Container(
      margin: EdgeInsets.only(top: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            valorUnitario,
            valorTotal,
          ],
        )
    );
    var comoLlegar= Container(
      margin: EdgeInsets.only(top: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Column(
              children: <Widget>[
                Container(
                  child: Widgets.titleStyleinfo('MAPA'),
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.map,
                    color: Colores.primaryColor,
                  ),
                  onPressed: (){
                    OverlayEntry overlayEntry;
                    overlayEntry = OverlayEntry(builder: (c) {
                      return MapaComplejo(data['complejo'], onClose: () => overlayEntry.remove());
                    });
                    Overlay.of(context).insert(overlayEntry);
                  },
                )
              ],
            )
          ],
        )
    );
    var bodyReserva=Container(
      width: MediaQuery.of(context).size.width,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.blue),
          gradient: Colores.primaryGradient,
          image: data['cancha']['foto_cancha']!=null?
          DecorationImage(
              image: NetworkImage(data['cancha']['foto_cancha']),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken)
          ):
          DecorationImage(
              image: AssetImage('assets/images/canchaFutbol.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken)
          )
      ),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              titleComplejo,
              titleCancha,
              dateTime,
              valor,
              comoLlegar
            ],
          ),
        ],
      ),
    );

    return InkWell(
      child: Card(
        margin: EdgeInsets.only(bottom: 12),
        child: bodyReserva,
      ),
      onTap: (){

      },
    );
  }
  

}
