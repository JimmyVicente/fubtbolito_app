import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futbolito_app/controller/canchaController.dart';
import 'package:futbolito_app/controller/reservaController.dart';
import 'package:futbolito_app/model/user.dart';
import 'package:futbolito_app/ui/cancha/reservaTime.dart';
import 'package:futbolito_app/ui/globales/Alerts.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:intl/intl.dart';

class CanchaPage extends StatefulWidget {
  final complejo;
  CanchaPage(this.complejo);
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
    var response = await canchaController().getCanchas('${widget.complejo['id'].toString()}');
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
    final textTitleComplejo = Container(
      child: Text(
        widget.complejo['nombre_complejo'],
        style: TextStyle(
          color: Colores.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          decorationColor: Colors.black,
        ),
      ),
    );
    final textInfoPhone = Container(
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
              widget.complejo['telefono_complejo'],
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ],
      ),
    );
    final textInfoDirecion = Container(
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
                widget.complejo['direccion_complejo'],
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ],
        )
    );
    final reservations = Container(
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
      decoration:BoxDecoration(
          gradient: Colores.secondGradient,
          image:  widget.complejo['foto_complejo'] != null ?
          DecorationImage(
              image: NetworkImage(widget.complejo['foto_complejo'].toString()),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken)
          ):
          DecorationImage(
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
                textTitleComplejo,
                textInfoPhone,
                textInfoDirecion,
                reservations
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
    final textTitleSelectCancha = Container(
      padding: EdgeInsets.only(top: 2),
      alignment: Alignment.center,
      child: Text(
        'Seleccione una cancha:',
        style: TextStyle(
          color: Colores.primaryColor,
        ),
      ),
    );
    final listCanchas = Container(
      height: heightS/2*0.4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dataCancha == null ? 0 : dataCancha.length,
        itemBuilder: (BuildContext context, int i) {
          return cancha(dataCancha[i], i);
        },
      ),
    );
    final textTitleDate = Container(
      padding: EdgeInsets.only(top: 2),
      alignment: Alignment.center,
      child: Text(
        'Selecione la fecha:',
        style: TextStyle(
          color: Colores.primaryColor,
        ),
      ),
    );
    final imputDateText = Container(
        margin: EdgeInsets.only(right: 50, left: 50, top: 10, bottom: 10),
        decoration: BoxDecoration(
          gradient: Colores.secondGradient,
          borderRadius: BorderRadius.circular(10)
        ),
        width: widthS,
        alignment: Alignment.center,
        child: FlatButton(
          child:Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
          onPressed: ()=> selectDate(),
        )
    );
    final textTitleTime = Container(
      padding: EdgeInsets.only(top: 2),
      alignment: Alignment.center,
      child: Text(
        'Selecione el horario:',
        style: TextStyle(
          color: Colores.primaryColor,
        ),
      ),
    );
    final textTitleHour = Container(
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
    final imputTime = Container(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    gradient: Colores.secondGradient,
                    borderRadius: BorderRadius.circular(10)
                ),
                margin: EdgeInsets.all(2),
                child: FlatButton(
                  child: Text('${selectedHourStart.format(context)}'),
                  onPressed: () async {
                    selectHourStart();
                  },
                )
            ),
            Container(
              margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    gradient: Colores.secondGradient,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: FlatButton(
                  child: Text('${selectedHourEnd.format(context)}'),
                  onPressed: () {
                    selectHourEnd();
                  },
                )
            )
          ],
        )
    );
    final textTitleValor = Container(
      alignment: Alignment.center,
      child: Text(
        'Valor a pagar',
        style: TextStyle(
          color: Colores.primaryColor,
        ),
      ),
    );
    final imputValor = Container(
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
    final buttomReservationCancha = Container(
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
    final body = Container(
        margin: EdgeInsets.only(right: 10, left: 10, top: heightS/2*0.38, bottom: 10),
        child: Card(
          child: this._isLoadingServices ? Center(child: CircularProgressIndicator()):
          dataCancha == null ? _nullCanchas :
          ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
              textTitleSelectCancha,
              listCanchas,
              textTitleDate,
              imputDateText,
              textTitleTime,
              textTitleHour,
              reservaTime(idCancha),
              textTitleValor,
              imputValor,
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
                        body
                      ],
                    ),
                  ),
                  buttomReservationCancha
                ],
              ),
            ]
        ),
    );
  }

  Widget cancha(Map data, int i) {
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

    final image = Container(
        width: 220,
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: Colores.primaryGradient,
            image: data['foto_cancha']!=null?
            DecorationImage(
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
        child: image,
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
      int idUser=User.id;
      final validacionReserva = await reservaController().validarReserva(idCancha, selectedDate, selectedHourStart, selectedHourEnd);
     print(validacionReserva);
      if(validacionReserva==true){
       final response = await reservaController()
           .postReserva(
           idUser,
           idCancha,
           selectedDate,
           selectedHourStart,
           selectedHourEnd,
           valorUnitario,
           valorUnitario
       );
       AlertWidget().showEditSuccess(context, "Cancha reservada");
     }

    }else{
      AlertWidget().showToastError("Selecione una cancha");
    }

  }
}
