import 'dart:async';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/Fuctions.dart';
import 'package:futbolito_app/controller/comunication.dart';
import 'package:futbolito_app/controller/signinController.dart';
import 'package:futbolito_app/controller/userController.dart';
import 'package:futbolito_app/ui/globales/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with signinController{
  TextEditingController controllerIP;
  bool enableButton = false;
  String getIp='';

  Timer _timer;
  Future<void> getUser()async{
    var dataUserpersistence = await signinController().loadSesion();
    await Fuctions().insertIpPreferences(controllerIP.text);
    setState(() {});
    Comunication.IP = await Fuctions().getIp();
    if(dataUserpersistence !=null){
      await userController().getDataUser();
    }
    verificarLogeado(context);
  }

  Future<String> getIpPersistence()async{
    getIp= await Fuctions().getIp();
    Comunication.IP = getIp;
    setState((){});
    if(getIp!=null){
      controllerIP = new TextEditingController(text: getIp);
      getUser();
    }else{
      controllerIP = new TextEditingController();
    }
    return getIp;
  }

  @override
  void initState() {
    super.initState();
    getIpPersistence();
   // _timer = Timer(const Duration(milliseconds: 800), _onShowLogin);

  }

//  @override
//  void dispose() {
//    _timer.cancel();
//    super.dispose();
//  }

  void _onShowLogin() {
    if(mounted){
      verificarLogeado(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colores.primaryColor
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('BIENVENIDO A FUTBOLITO' ,style: TextStyle(color: Colors.white),),
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                controller: controllerIP,
                onChanged: (text) {
                  setState(() {
                    enableButton = text.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: 'Ejemplo: 0.0.0.0:0000',
                    labelText: 'IP',
                    suffixIcon: enableButton
                        ? IconButton(
                      color: Theme.of(context).primaryColor,
                      icon: Icon(
                        Icons.send,
                      ),
                      disabledColor: Colors.grey,
                      onPressed: (){
                        getUser();
                      },
                    )
                        : IconButton(
                      color: Colors.blue,
                      icon: Icon(
                        Icons.send,
                      ),
                      disabledColor: Colors.grey,
                      onPressed: null,
                    )
                ),
              ),
            ),
              Container(
                child: FlatButton(
                    child: Text(
                        'BORRAR IP',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  onPressed: (){
                    Fuctions().clearIp();
                    controllerIP = new TextEditingController(text: '');
                  },

                ),
              )
            ],
          )
        )
      ),
    );
  }

}
