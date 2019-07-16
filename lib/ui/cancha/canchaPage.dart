import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futbolito_app/controller/canchaController.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class CanchaPage extends StatefulWidget {
  final Complejo;
  String image;
  CanchaPage(this.Complejo, this.image);
  @override
  _CanchaPageState createState() => _CanchaPageState();
}

class _CanchaPageState extends State<CanchaPage> {
  DateTime selectedDate = DateTime.now();
  DateTime selectedHourStart = DateTime.now();
  DateTime selectedHourEnd= DateTime.now();
  //valor
  int index=0;
  double valorUnitario=00.00;
  double valorTotal=00.00;

  bool _isLoadingServices = true;
  List dataCancha;

  Future _getDataCanchas()async{
    var response = await canchaController().getCanchas('${widget.Complejo['id'].toString()}');
    setState(() {
      dataCancha = response;
      _isLoadingServices=false;
    });
  }
  @override
  void initState(){
    super.initState();
    _getDataCanchas();
  }
  @override
  Widget build(BuildContext context) {
    final _TextTitleComplejo =Container(
      child: Text(
        widget.Complejo['nombre_complejo'],
        style: TextStyle(
            color: Colores.primaryColor,
            fontSize: 20,
          fontWeight: FontWeight.bold,
          decorationColor: Colors.black
        ),
      ),
    );
    final _TextInfoPhone= Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 5.0),
            child: Icon(CupertinoIcons.phone, color: Colores.primaryColor, size: 15,),
          ),
          Container(
            child: Text(widget.Complejo['telefono_complejo'], style: TextStyle(color: Colors.white, fontSize: 10),),
          ),
        ],
      ),
    );
    final _TextInfoDirecion= Container(
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 5.0),
            child: Icon(CupertinoIcons.location, color: Colores.primaryColor, size: 15,),
          ),
          Container(
            child: Text(widget.Complejo['direccion_complejo'], style: TextStyle(color: Colors.white, fontSize: 10),),
          ),
        ],
      )
    );
    final _Reservations=Container(
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
                              border: Border.all(color: Colors.white)
                          ),
                          child: Icon(CupertinoIcons.person, color: Colors.white,),
                        )
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 12),
                        child: Container(
                          padding: EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey,
                              border: Border.all(color: Colors.white)
                          ),
                          child: Icon(CupertinoIcons.person, color: Colors.white,),
                        )
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 24),
                        child: Container(
                          padding: EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey,
                              border: Border.all(color: Colors.white)
                          ),
                          child: Icon(CupertinoIcons.person, color: Colors.white,),
                        )
                    ),

                  ],
                )
            ),
            Container(
              child: Text(
                '+ 10 reservas',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colores.primaryColor
                ),
              ),
            )
          ],
        )
    );
    final _image= Container(
      height: 180,
      width: MediaQuery.of(context).size.width,
      decoration: widget.image!=null?
      BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
          )
      ):
      BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/trees.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
          )
      ),
      child:  Stack(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white,),
              onPressed: (){
                Navigator.pop(context);
              }
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _TextTitleComplejo,
                _TextInfoPhone,
                _TextInfoDirecion,
                _Reservations
              ],
            ),
          )
        ],
      ),
    );
    final _nullCanchas=Center(
      child: Text(
        'No Hay canchas para este complejo :(',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black,
            fontSize: 20
        ),
      ),
    );
    final _TextTitleSelectCancha=Container(
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
        padding: EdgeInsets.only(left: 20, right: 20,),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dataCancha==null?0:dataCancha.length,
            itemBuilder: (BuildContext context, int i){
              return Cancha(dataCancha[i], i);
            },
          ),
    );
    final _TextTitleDate=Container(
      padding: EdgeInsets.only(top: 2),
      alignment: Alignment.center,
      child: Text(
        'Selecione la fecha:',
        style: TextStyle(
            color: Colores.primaryColor,
        ),
      ),
    );
    final _ImputDateText=Container(
        padding: EdgeInsets.only(top: 2),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.calendarAlt),
                  onPressed: ()async{
//                    DatePicker.showDatePicker(context,
//                        showTitleActions: true,
//                        currentTime: selectedDate,
//                        minTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
//                        maxTime: DateTime(DateTime.now().year+1, DateTime.now().month, DateTime.now().day),
//                        onConfirm: (date) {
//                          setState(() {
//                            selectedDate=date;
//                          });
//                        },
//                        locale: LocaleType.es
//                    );
                    var picked= await canchaController().selectDate(context, selectedDate);
                    if (picked != null && picked != selectedDate)
                      setState(() {
                        selectedDate = picked;
                      });
                  },
                )
            ),
            Container(
                padding: EdgeInsets.only(right: 20),
                child:  Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
            ),
          ],
        )
    );
    final _TextTitleTime=Container(
      padding: EdgeInsets.only(top: 2),
      alignment: Alignment.center,
      child: Text(
        'Selecione el horario:',
        style: TextStyle(
          color: Colores.primaryColor,
        ),
      ),
    );
    final _TextTitleHour=Container(
        padding: EdgeInsets.only(top: 3),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                    'Hoara de inicio',
                  style: TextStyle(
                    fontSize: 10
                  ),
                )
            ),
            Container(
                child: Text(
                    'Hora de salida',
                  style: TextStyle(
                      fontSize: 10
                  ),
                )
            )
          ],
        )
    );
    final _ImputTime=Container(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: IconButton(
                  icon: Icon(CupertinoIcons.time),
                  onPressed: ()async{
                    selectHourStart();
                  },
                )
            ),
            Container(
                padding: EdgeInsets.only(right: 20),
                child: Text(DateFormat("h:mm a").format(selectedHourStart))
            ),
            Container(
                child: IconButton(
                  icon: Icon(CupertinoIcons.time),
                  onPressed: (){
                    selectHourEnd();
                  },
                )
            ),
            Container(
                child: Text(DateFormat("h:mm a").format(selectedHourEnd))
            )
          ],
        )
    );
    final _TextTitleValor=Container(
      alignment: Alignment.center,
      child: Text(
        'Valor a pagar',
        style: TextStyle(
          color: Colores.primaryColor,
        ),
      ),
    );
    final _ImputValor=Container(
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
            Container(
                child: Text('${valorTotal}')
            )
          ],
        )
    );
    final _TextTitleLocationComplejo=Container(
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
        padding: EdgeInsets.all(12.0),
        color: Colores.primaryColor,
        child: InkWell(
          child: Text(
            'RESERVAR CANCHA',
            style: new TextStyle(
                color: Colors.white,
                fontSize: 15
            ),
            textAlign: TextAlign.center,
          ),
          onTap: (){

          },
        )
    );
    final _body =Container(
        padding: EdgeInsets.only(right: 10, left: 10, top: 150 , bottom: 10),
        child: Card(
            child: this._isLoadingServices ? Center(child: CircularProgressIndicator()):
            dataCancha == null ? _nullCanchas:
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _TextTitleSelectCancha,
                  Expanded(child: _ListCanchas),
                  _TextTitleDate,
                  _ImputDateText,
                  _TextTitleTime,
                  _TextTitleHour,
                  _ImputTime,
                  _TextTitleValor,
                  _ImputValor,
                  _TextTitleLocationComplejo,
                  Expanded(child: Widgets.GoogleMaps(widget.Complejo['nombre_complejo'], -4.009644, -79.203737)),
                ],
              ),
            )
        )
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
            children: [
              Widgets.wallpaper,
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
      )
    );
  }

  Widget Cancha(Map data, int i){
    final _TitleCancha=Container(
      child: Text(data['descripcion_cancha'],
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
    );
    final _SelectCancha=Container(
      child: CircleAvatar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        child: Icon(
          FontAwesomeIcons.check,
          color: Colors.green,
        ),
      )
    );

    final _Image= Container(
        width: 250,
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/canchaFutbol.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.colorBurn)
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _TitleCancha,
          ],
        )
    );
    final _ImageSelect= Container(
        width: 250,
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/canchaFutbol.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.colorBurn)
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _TitleCancha,
            _SelectCancha
          ],
        )
    );
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: InkWell(
        child: data['estado_cancha']?_Image:_ImageSelect,
          onTap: (){
          setState(() {
            if(data['estado_cancha']){
              dataCancha[index]['estado_cancha']=true;
              data['estado_cancha']=false;
              valorUnitario=double.parse(data['valor_dia']);
              valorTotal=double.parse(data['valor_dia']);
              index=i;
            }else{
              data['estado_cancha']=true;
              valorUnitario=0.0;
              valorTotal=0.0;
            }
          });
          print(data['valor_dia']);
        },
      ),
    );
  }

  selectHourStart(){
    DatePicker.showTimePicker(context,
        showTitleActions: true,
        onConfirm: (date) {
          setState(() {
            selectedHourStart=date;
          });
        },
        currentTime: selectedHourStart,
        locale: LocaleType.es
    );
  }

  selectHourEnd(){
    DatePicker.showTimePicker(context,
        showTitleActions: true,
        onConfirm: (date) {
          setState(() {
            selectedHourEnd=date;
          });
        },
        currentTime: selectedHourStart,
        locale: LocaleType.es
    );
  }
}
