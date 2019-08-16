import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:futbolito_app/ui/globales/ui/blur_background.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'colors.dart';

class Widgets  {

  static Widget wallpaper = BlurBackground(
    assetImage: 'assets/images/home.jpg',
    backDropColor: Colors.black.withOpacity(0.1),
    blurX: 0.5,
    blurY: 0.5,
  );

  static Widget GoogleMaps(String titleMarker, double latitude, double longitude){
    Completer<GoogleMapController> _controller = Completer();
    void _onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
    }

    final googleMaps = GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target:  LatLng(latitude, longitude),
        zoom: 16.5,
      ),
      myLocationEnabled: true,
      markers:{
        Marker(
          markerId: MarkerId('1'),
          position:  LatLng(latitude, longitude),
          infoWindow: InfoWindow(
              title: titleMarker,
              snippet: 'Ver en Google Maps |->',
          ),

          icon: BitmapDescriptor.defaultMarker,
        )
      },
    );
    return googleMaps;
  }

  void showAlert(BuildContext context, String title, Function function) {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        content: new Text(title),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true, child: new Text("NO"),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true, child: new Text("Si"),
            onPressed: (){
              Navigator.pop(context);
              function();
            },
          )
        ],
      ),
    );
  }

  showDialogLoading(BuildContext context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.green,
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      title: 'ESPERE',
      content: Center(
        child: CircularProgressIndicator(),
      ),
      buttons: [
      ],
    ).show();
  }

  void showDialogInfo(BuildContext context, String title, String body, Function function) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Column(
              children: <Widget>[
                Text(title, textAlign: TextAlign.center, style: TextStyle(color: Colores.primaryColor),),
                Divider(color: Colores.primaryColor,),
              ],
            ),
            children: <Widget>[
              SimpleDialogOption(
                  child: Column(
                    children: <Widget>[
                      Text(body,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300
                        ),
                      )
                    ],
                  )
              ),
              SimpleDialogOption(
                child: RaisedButton(
                  child: Text('ACEPTAR', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18),),
                  color: Colores.primaryColor,
                  onPressed: (){
                    function();
                  },
                ),
              )
            ],
          );
        });
  }

  static Widget titleStyleinfo(String title){
    Color titleInfoReserva= Colors.green;
    return Text(
      title,
      style: TextStyle(
          color: titleInfoReserva,
          fontSize: 8,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic
      ),
      textAlign: TextAlign.center,
    );
  }

}


