import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futbolito_app/controller/Fuctions.dart';
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
      if(picked.hour<DateTime.now().hour){
        setState(() {
          selectedHourStart = TimeOfDay(
              hour: DateTime.now().hour+1,
              minute: 00
          );;
          selectedHourEnd=TimeOfDay(
              hour:selectedHourStart.hour+1,
              minute: selectedHourStart.minute
          );
          var valorT=(selectedHourEnd.hour-selectedHourStart.hour)*valorUnitario;
          valorTotal=valorT;
        });
        AlertWidget().showToastError("La hora de inicio debe ser mayor a la hora actual");
      }else{
        setState(() {
          selectedHourStart = picked;
          selectedHourEnd=TimeOfDay(
              hour: picked.hour+1,
              minute: picked.minute
          );
          var valorT=(selectedHourEnd.hour-selectedHourStart.hour)*valorUnitario;
          valorTotal=valorT;
        });
      }
    }
  }

  selectHourEnd() async{
    var picked = await canchaController().selectTime(
        context,
        TimeOfDay(
            hour: selectedHourEnd.hour,
            minute: selectedHourEnd.minute
        )
    );
    if (picked != null && picked != selectedDate){
      if(picked.hour<=selectedHourStart.hour){
        setState(() {
          selectedHourEnd=TimeOfDay(
              hour: selectedHourStart.hour+1,
              minute: selectedHourStart.minute
          );
          var valorT=(selectedHourEnd.hour-selectedHourStart.hour)*valorUnitario;
          valorTotal=valorT;
        });
        AlertWidget().showToastError("La hora de salida debe ser mayor que la de inicio");
      }else{
        setState(() {
          selectedHourEnd = picked;
          var valorT=(selectedHourEnd.hour-selectedHourStart.hour)*valorUnitario;
          valorTotal=valorT;
        });
      }
    }
  }

  reserva() async{
    if(idCancha!=null){
      final validacionReserva = await reservaController().validarReserva(idCancha, selectedDate, selectedHourStart, selectedHourEnd);
      if(validacionReserva==true){
        Widgets().showDialogLoading(context);
        final response = await reservaController()
            .postReserva(
            idCancha,
            selectedDate,
            selectedHourStart,
            selectedHourEnd,
            valorUnitario,
            valorTotal
        );
        if(response['usuario']!=null){
          Navigator.of(context, rootNavigator: true).pop();
          AlertWidget().showEditSuccessRegresar(context, "Cancha reservada, revisa en tu historial");
        }else{
          AlertWidget().showEditError(context, "No se pudo reservar Cacha");
        }
      }
    }else{
      AlertWidget().showToastError("Selecione una cancha");
    }
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
    var textTitleComplejo = Container(
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
    var textInfoPhone = Container(
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
    var textInfoDirecion = Container(
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
    var image = Container(
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
              ],
            ),
          ],
        ),
      )
    );
    var nullCanchas = Center(
      child: Text(
        'No Hay canchas para este complejo :(',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
    );
    var textTitleSelectCancha = Container(
      padding: EdgeInsets.only(top: 2),
      alignment: Alignment.center,
      child: Text(
        'Seleccione una cancha:',
        style: TextStyle(
          color: Colores.primaryColor,
        ),
      ),
    );
    var listCanchas = Container(
      height: heightS/2*0.4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dataCancha == null ? 0 : dataCancha.length,
        itemBuilder: (BuildContext context, int i) {
          return cancha(dataCancha[i], i);
        },
      ),
    );
    var textTitleDate = Container(
      padding: EdgeInsets.only(top: 2),
      alignment: Alignment.center,
      child: Text(
        'Selecione la fecha:',
        style: TextStyle(
          color: Colores.primaryColor,
        ),
      ),
    );
    var imputDateText = Container(
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
    var textTitleTime = Container(
      padding: EdgeInsets.only(top: 2),
      alignment: Alignment.center,
      child: Text(
        'Selecione el horario:',
        style: TextStyle(
          color: Colores.primaryColor,
        ),
      ),
    );
    var textTitleHour = Container(
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
    var imputTime = Container(
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
                  child: Text('${Fuctions().formatTimeHourMinuteString(selectedHourStart)}'),
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
                  child: Text('${Fuctions().formatTimeHourMinuteString(selectedHourEnd)}'),
                  onPressed: () {
                    selectHourEnd();
                  },
                )
            )
          ],
        )
    );
    var textTitleValor = Container(
      alignment: Alignment.center,
      child: Text(
        'Valor a pagar',
        style: TextStyle(
          color: Colores.primaryColor,
        ),
      ),
    );
    var imputValor = Container(
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
    var buttomReservationCancha = Container(
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
    var body = Container(
        margin: EdgeInsets.only(right: 10, left: 10, top: heightS/2*0.38, bottom: 10),
        child: Card(
          child: this._isLoadingServices ? Center(child: CircularProgressIndicator()):
          dataCancha == null ? nullCanchas :
          ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
              textTitleSelectCancha,
              listCanchas,
              textTitleDate,
              imputDateText,
              textTitleTime,
              textTitleHour,
              imputTime,
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
              Column(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        image,
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
    var titleCancha = Container(
      child: Text(
        data['descripcion_cancha'].toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
    var selectCanchas = Container(
        child: CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.5),
          child: Icon(
            FontAwesomeIcons.check,
            color: Colors.green,
          ),
        ),
    );
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
            titleCancha:
            Column(
              children: <Widget>[
                titleCancha,
                selectCanchas
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
}
