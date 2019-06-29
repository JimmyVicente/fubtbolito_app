import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaComplejo extends StatefulWidget {
  @override
  _MapaComplejoState createState() => _MapaComplejoState();
}

class _MapaComplejoState extends State<MapaComplejo> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(-4.009644, -79.203737);
  MapType _currentMapType = MapType.normal;
  LatLng _lastMapPosition = _center;
  final Set<Marker> _markers = {};


  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.hybrid
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Marcador',
          snippet: 'calle',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CupertinoNavigationBar(),
      body: _body(),
    );
  }

  Widget _body(){
    final googleMaps = GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 14.5,
      ),
      mapType: _currentMapType,
      markers: _markers,
      onCameraMove: _onCameraMove,
    );
    final botonIndicador = Container(
      alignment: Alignment.center,
      child: Container(
          padding: EdgeInsets.only(bottom: 37),
          child: Image(
            width: 50,
            image: AssetImage(
              'assets/images/icon/location.png',),
          )
      ),
    );
    final botonFlotante =Container(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topRight,
          child: Column(
            children: <Widget> [
              FloatingActionButton(
                onPressed: _onMapTypeButtonPressed,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.green,
                child: const Icon(Icons.map, size: 36.0),
              ),
              SizedBox(height: 16.0),
              FloatingActionButton(
                onPressed: _onAddMarkerButtonPressed,
                backgroundColor: Colors.green,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                // backgroundColor: Colors.green,
                child: const Icon(Icons.add_location, size: 36.0),
              ),
            ],
          ),
        )
    );
    return SafeArea(
      child: Stack(
        children: <Widget>[
          googleMaps,
          botonIndicador,
          botonFlotante
        ],
      ),
    );
  }

}
