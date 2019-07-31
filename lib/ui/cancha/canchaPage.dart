import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futbolito_app/controller/canchaController.dart';
import 'package:futbolito_app/controller/reservaController.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:intl/intl.dart';

class CanchaPage extends StatefulWidget {
  final user;
  final Complejo;
  CanchaPage(this.user,this.Complejo);
  @override
  _CanchaPageState createState() => _CanchaPageState();
}

class _CanchaPageState extends State<CanchaPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedHourStart = TimeOfDay(hour: DateTime.now().hour+1, minute: 00);
  TimeOfDay selectedHourEnd = TimeOfDay(hour: DateTime.now().hour+2, minute: 00);
  //cancha
  int idCancha;
  //valor
  int index = 0;
  double valorUnitario = 00.00;
  double valorTotal = 00.00;

  bool _isLoadingServices = true;
  List dataCancha;

  Future _getDataCanchas() async {
    var response = await canchaController().getCanchas('${widget.Complejo['id'].toString()}');
    setState(() {
      dataCancha = response;
      _isLoadingServices = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataCanchas();
  }

  @override
  Widget build(BuildContext context) {
    var heightS = MediaQuery.of(context).size.height;
    var widthS = MediaQuery.of(context).size.width;
    final _TextTitleComplejo = Container(
      child: Text(
        widget.Complejo['nombre_complejo'],
        style: TextStyle(
          color: Colores.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          decorationColor: Colors.black,
        ),
      ),
    );
    final _TextInfoPhone = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 5.0),
            child: Icon(
              CupertinoIcons.phone,
              color: Colores.primaryColor,
              size: 15,
            ),
          ),
          Container(
            child: Text(
              widget.Complejo['telefono_complejo'],
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ],
      ),
    );
    final _TextInfoDirecion = Container(
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
                widget.Complejo['direccion_complejo'],
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ],
        ));
    final _Reservations = Container(
        padding: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 15),
                child: Stack(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey,
                              border: Border.all(color: Colors.white)),
                          child: Icon(
                            CupertinoIcons.person,
                            color: Colors.white,
                          ),
                        )),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 12),
                        child: Container(
                          padding: EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey,
                              border: Border.all(color: Colors.white)),
                          child: Icon(
                            CupertinoIcons.person,
                            color: Colors.white,
                          ),
                        )),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 24),
                        child: Container(
                          padding: EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey,
                              border: Border.all(color: Colors.white)),
                          child: Icon(
                            CupertinoIcons.person,
                            color: Colors.white,
                          ),
                        )),
                  ],
                )),
            Container(
              child: Text(
                '+ 10 reservas',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colores.primaryColor),
              ),
            )
          ],
        )
    );
    final _image = Container(
      height: heightS/2*0.45,
      width: widthS,
      decoration: widget.Complejo['foto_complejo'] != null
          ? BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.Complejo['foto_complejo'].toString()),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken)))
          : BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/trees.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _TextTitleComplejo,
                _TextInfoPhone,
                _TextInfoDirecion,
                _Reservations
              ],
            ),
          ],
        ),
      )
    );
    final _nullCanchas = Center(
      child: Text(
        'No Hay canchas para este complejo :(',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
    );
    final _TextTitleSelectCancha = Container(
      padding: EdgeInsets.only(top: 2),
      alignment: Alignment.center,
      child: Text(
        'Seleccione una cancha:',
        style: TextStyle(
          color: Colores.primaryColor,
        ),
      ),
    );
    final _ListCanchas = Container(
      height: heightS/2*0.4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dataCancha == null ? 0 : dataCancha.length,
        itemBuilder: (BuildContext context, int i) {
          return Cancha(dataCancha[i], i);
        },
      ),
    );
    final _TextTitleDate = Container(
      padding: EdgeInsets.only(top: 2),
      alignment: Alignment.center,
      child: Text(
        'Selecione la fecha:',
        style: TextStyle(
          color: Colores.primaryColor,
        ),
      ),
    );
    final _ImputDateText = Container(
        margin: EdgeInsets.only(right: 50, left: 50),
        child: InkWell(
          child: Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              child: Text('AB'),
            ),
            label: Text('Aaron Burr'),
          ),
          onTap: ()=> selectDate(),
        )

//        Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Container(
//                child: IconButton(
//                  icon: Icon(FontAwesomeIcons.calendarAlt),
//                  onPressed: () {
//                    selectDate();
//                  },
//                )
//            ),
//            Container(
//              padding: EdgeInsets.only(right: 20),
//              child: Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
//            ),
//          ],
//        )
    );
    final _TextTitleTime = Container(
      padding: EdgeInsets.only(top: 2),
      alignment: Alignment.center,
      child: Text(
        'Selecione el horario:',
        style: TextStyle(
          color: Colores.primaryColor,
        ),
      ),
    );
    final _TextTitleHour = Container(
        padding: EdgeInsets.only(top: 3),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  'Hoara de inicio',
                  style: TextStyle(fontSize: 10),
                )
            ),
            Container(
                child: Text(
                  'Hora de salida',
                  style: TextStyle(fontSize: 10),
                )
            )
          ],
        )
    );
    final _ImputTime = Container(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: IconButton(
                  icon: Icon(CupertinoIcons.time),
                  onPressed: () async {
                    selectHourStart();
                  },
                )
            ),
            Container(
                padding: EdgeInsets.only(right: 20),
                child: Text('${selectedHourStart.hour}:${selectedHourStart.minute}h')
            ),
            Container(
                child: IconButton(
                  icon: Icon(CupertinoIcons.time),
                  onPressed: () {
                    selectHourEnd();
                  },
                )
            ),
            Container(
                child: Text('${selectedHourEnd.hour}:${selectedHourEnd.minute}')
            )
          ],
        )
    );
    final _TextTitleValor = Container(
      alignment: Alignment.center,
      child: Text(
        'Valor a pagar',
        style: TextStyle(
          color: Colores.primaryColor,
        ),
      ),
    );
    final _ImputValor = Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(Icons.attach_money),
            ),
            Container(
                padding: EdgeInsets.only(right: 15),
                child: Text('${valorUnitario}')
            ),
            Container(
              child: Icon(Icons.attach_money),
            ),
            Container(child: Text('${valorTotal}')
            )
          ],
        )
    );
    final _TextTitleLocationComplejo = Container(
      padding: EdgeInsets.only(top: 2, bottom: 4),
      child: Text(
        'Ubicación:',
        style: TextStyle(
          color: Colores.primaryColor,
        ),
      ),
    );
    final _ButtomReservationCancha = Container(
        width: MediaQuery.of(context).size.width,
        color: Colores.primaryColor,
        child: FlatButton(
          child: Text(
            'RESERVAR CANCHA',
            style: new TextStyle(color: Colors.white, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            reserva();
          },
        )
    );
    final _body = Container(
        margin: EdgeInsets.only(right: 10, left: 10, top: heightS/2*0.38, bottom: 10),
        child: Card(
          child: this._isLoadingServices ? Center(child: CircularProgressIndicator()):
          dataCancha == null ? _nullCanchas :
          ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
              _TextTitleSelectCancha,
              _ListCanchas,
              _TextTitleDate,
              _ImputDateText,
              _TextTitleTime,
              _TextTitleHour,
              _ImputTime,
              _TextTitleValor,
              _ImputValor,
              _TextTitleLocationComplejo,
            ],
          ),
        )
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Stack(
            children: [
              Widgets.wallpaper,
              _image,
              Column(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        _image,
                        _body
                      ],
                    ),
                  ),
                  _ButtomReservationCancha
                ],
              ),
            ]
        ),
    );
  }

  Widget Cancha(Map data, int i) {
    final _TitleCancha = Container(
      child: Text(
        data['descripcion_cancha'].toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
    final _SelectCancha = Container(
        child: CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.5),
          child: Icon(
            FontAwesomeIcons.check,
            color: Colors.green,
          ),
        ));

    final _Image = Container(
        width: 220,
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
            image: data['foto_cancha']!=null?DecorationImage(
                image: NetworkImage(data['foto_cancha'].toString()),
                fit: BoxFit.cover,
                colorFilter: data['estado_cancha']?
                ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.colorBurn):
                ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.colorBurn)
            ):DecorationImage(
                image: AssetImage('assets/images/canchaFutbol.png'),
                fit: BoxFit.cover,
                colorFilter: data['estado_cancha']?
                ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.colorBurn):
                ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.colorBurn)
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            data['estado_cancha']?
            _TitleCancha:
            Column(
              children: <Widget>[
                _TitleCancha,
                _SelectCancha
              ],
            )
          ],
        ));
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: InkWell(
        child: _Image,
        onTap: () {
          selectCancha(data, i);
        },
      ),
    );
  }
  selectCancha(Map data, int i){
    setState(() {
      if (data['estado_cancha']) {
        dataCancha[index]['estado_cancha'] = true;
        data['estado_cancha'] = false;
        valorUnitario = double.parse(data['valor_dia']);
        valorTotal = double.parse(data['valor_dia']);
        index = i;
        idCancha=data['id'];
      } else {
        data['estado_cancha'] = true;
        valorUnitario = 0.0;
        valorTotal = 0.0;
        idCancha=null;
      }
    });
  }

  selectDate() async{
    var picked = await canchaController().selectDate(context, selectedDate);
    if (picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
      });
    }
  }

  selectHourStart() async{
    var picked = await canchaController()
        .selectTime(
        context,
        TimeOfDay(
            hour: selectedHourStart.hour,
            minute: selectedHourStart.minute
        )
    );
    if (picked != null && picked != selectedDate){
      setState(() {
        selectedHourStart = picked;
        selectedHourEnd=TimeOfDay(
            hour: picked.hour+1,
            minute: picked.minute
        );
      });
    }
  }

  selectHourEnd() async{
    var picked = await canchaController()
        .selectTime(
        context,
        TimeOfDay(
            hour: selectedHourEnd.hour,
            minute: selectedHourEnd.minute
        )
    );
    if (picked != null && picked != selectedDate){
      setState(() {
        selectedHourEnd = picked;
      });
    }
  }

  reserva() async{
    if(idCancha!=null){
      int idUser=widget.user['id'];
      String Date= DateFormat('yyyy-MM-dd').format(selectedDate);
      String startTime='${selectedHourStart.hour}:${selectedHourStart.minute}:00';
      String endTime='${selectedHourEnd.hour}:${selectedHourEnd.minute}:00';
//      final response = await reservaController()
//          .postReserva(
//          idUser,
//          idCancha,
//          Date,
//          startTime,
//          endTime,
//          valorUnitario,
//          valorUnitario
//      );
      final response = await reservaController().validarReserva(dataCancha, idCancha, Date, startTime, endTime);
      print(response);
    }else{
      print('Selecione una cancha');
    }

  }
}
