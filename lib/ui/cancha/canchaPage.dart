import 'dart:async';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/canchaController.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/signin/ui/blur_background.dart';
import 'package:futbolito_app/ui/signin/ui/hidden_scroll_behavior.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CanchaPage extends StatefulWidget {
  final Complejo;
  CanchaPage(this.Complejo);
  @override
  _CanchaPageState createState() => _CanchaPageState();
}

class _CanchaPageState extends State<CanchaPage> with canchaController{
  bool _isLoadingServices = true;
  List dataCancha;

  Future _getData()async{
    var response = await getCanchas('${widget.Complejo['id'].toString()}');
    setState(() {
      dataCancha = response;
      _isLoadingServices=false;
    });
  }

  @override
  void initState(){
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
        backgroundColor: Colores.primaryColor,
        centerTitle: true,
        title: Text('Canchas')
    );
    final _TitleCancha = Container(
        padding: EdgeInsets.only(left: 30, top: 10),
        child: Text(
          'Canchas:',
          style: TextStyle(
              fontSize: 20,
              color: Colores.primaryColor
          ),
        )
    );

    final listCanchas = Container(
        padding: EdgeInsets.only(left: 20, right: 20,),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: dataCancha == null ? 0 : dataCancha.length,
            itemBuilder: (BuildContext context, i) {
              return new Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        gradient: Colores.secondGradient
                      ),
                      child: ListTile(
                        title: Center(
                            child: Text(
                            dataCancha[i]['descripcion_cancha'].toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,

                              ),
                            )
                        ),
                        subtitle: Center(child: Text(
                            dataCancha[i]['complejo'].toString()),),
                      )
                  )
              ); //Container
            }
        )
    );

    final _TitleMapa = Container(
        padding: EdgeInsets.only(left: 30, top: 10, bottom: 10),
        child: Text(
          'Ubicación:',
          style: TextStyle(
              fontSize: 20,
              color: Colores.primaryColor
          ),
        )
    );

    final _FloatingActionButton= FloatingActionButton(
      child: Icon(Icons.add),
        onPressed: (){}
    );
    final _body =Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ScrollConfiguration(
                behavior: HiddenScrollBehavior(),
                child: listCanchas
            ),
          ),
          _TitleMapa,
          Expanded(
            child: _GoogleMaps(),
          )
        ],
      ),
    );
    var nullCanchas=Center(
      child: Text(
        'No Hay canchas para este complejo :(',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 20
        ),
      ),
    );

    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: _appBar,
        floatingActionButton: _FloatingActionButton,
        body: Stack(
            children: [
              BlurBackground(
                assetImage: 'assets/images/home.jpg',
                backDropColor: Colors.black.withOpacity(0.5),
                blurX: 0.5,
                blurY: 0.5,
              ),this._isLoadingServices
                  ? Center(
                child: CircularProgressIndicator(),
              ) :
              dataCancha == null ? nullCanchas:
              _body
            ]
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
        zoom: 14.5,
      ),
      myLocationEnabled: true,
      markers:{
        Marker(
          markerId: MarkerId('1'),
          position:  LatLng(-4.009644, -79.203737),
          infoWindow: InfoWindow(
            title: '${widget.Complejo['nombre_complejo']}',
            snippet: 'calles',
          ),
          icon: BitmapDescriptor.defaultMarker,
        )
      },
    );
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 80),
      child: googleMaps,
    );
  }

}



//class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() => new _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  final String data =
//      '[{"Description": "REGION I (ILOCOS REGION)", "PSGCCode": "010000000"}, {"ID": 2, "Code": "02", "Description": "REGION II (CAGAYAN VALLEY)", "PSGCCode": "020000000"}]';
//  List<Cancha> _cancha = [];
//  String selectedRegion;
//
//  @override
//  Widget build(BuildContext context) {
//    final json = JsonDecoder().convert(data);
//    _cancha = (json).map<Cancha>((item) => Cancha.fromJson(item)).toList();
//
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text("HOMA"),
//      ),
//      body: new Center(
//        child: new Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            DropdownButtonHideUnderline(
//              child: new DropdownButton<String>(
//                hint: new Text("Select Region"),
//                value: selectedRegion,
//                isDense: true,
//                onChanged: (String newValue) {
//                  setState(() {
//                    selectedRegion = newValue;
//                  });
//                  print(selectedRegion);
//                },
//                items: _cancha.map((Cancha map) {
//                  return new DropdownMenuItem<String>(
//                    value: map.descripcion_cancha,
//                    child: new Text(map.descripcion_cancha,
//                        style: new TextStyle(color: Colors.black)),
//                  );
//                }).toList(),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class Canchas {
//  final int regionid;
//  final String regionDescription;
//
//  Canchas({this.regionid, this.regionDescription});
//  factory Canchas.fromJson(Map<String, dynamic> json) {
//    return new Canchas(
//        regionid: json['ID'],
//        regionDescription: json['Description']);
//  }
//}
//
//class Cancha {
//  final int id;
//  final String descripcion_cancha;
//  final String valor_dia;
//  final String valor_noche;
//  final String estado_cancha;
//  final String complejo_id;
//
//  Cancha({this.id,
//    this.descripcion_cancha,
//    this.valor_dia,
//    this.valor_noche,
//    this.estado_cancha,
//    this.complejo_id});
//
//  factory Cancha.fromJson(Map<String, dynamic> json) {
//    return new Cancha(
//      id: json['id'],
//      descripcion_cancha:json['descripcion_cancha'],
//      valor_dia:json['valor_dia'],
//      valor_noche:json['valor_noche'],
//      estado_cancha: json['estado_cancha'],
//      complejo_id: json['complejo_id'],
//    );
//  }
//}