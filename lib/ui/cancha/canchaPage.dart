import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/canchaController.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.image),
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
            color: Colors.white,
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
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: dataCancha == null ? 0 : dataCancha.length,
            itemBuilder: (BuildContext context, i) {
              return new Container(
                width: 200,
                  margin: EdgeInsets.only(right: 20),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/canchaFutbol.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.luminosity)
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        dataCancha[i]['descripcion_cancha'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
              );
            }
        )
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
                  icon: Icon(CupertinoIcons.time),
                  onPressed: ()async{
                    var picked= await canchaController().selectDate(context);
                    if (picked != null && picked != selectedDate)
                      setState(() {
                        selectedDate = picked;
                      });
                  },
                )
            ),
            Container(
                padding: EdgeInsets.only(right: 20),
                child:  Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
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
    final _ImputTime=Container(
      padding: EdgeInsets.only(top: 2),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              child: IconButton(
                icon: Icon(CupertinoIcons.time),
                onPressed: (){

                },
              )
          ),
          Container(
            padding: EdgeInsets.only(right: 20),
              child: Text('HOLA')
          ),
          Container(
              child: IconButton(
                icon: Icon(CupertinoIcons.time),
                onPressed: (){

                },
              )
          ),
          Container(
              child: Text('HOLA')
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
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _TextTitleSelectCancha,
                  Expanded(child: _ListCanchas),
                  _TextTitleDate,
                  _ImputDateText,
                  _TextTitleTime,
                  _ImputTime,
                  _TextTitleLocationComplejo,
                  Expanded(flex:2,child: _GoogleMaps()),
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
              this._isLoadingServices ? Center(child: CircularProgressIndicator()):
              dataCancha == null ? _nullCanchas:
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

  Widget _GoogleMaps(){
    Completer<GoogleMapController> _controller = Completer();
    void _onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
    }

    final googleMaps = GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target:  LatLng(-4.009644, -79.203737),
        zoom: 16.5,
      ),
      myLocationEnabled: true,
      markers:{
        Marker(
          markerId: MarkerId('1'),
          position:  LatLng(-4.009644, -79.203737),
          infoWindow: InfoWindow(
              title: '${widget.Complejo['nombre_complejo']}',
              snippet: 'Click a la direccion para llegar'
          ),
          icon: BitmapDescriptor.defaultMarker,
        )
      },
    );
    return googleMaps;
  }
}
