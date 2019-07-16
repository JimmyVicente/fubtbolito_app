import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futbolito_app/controller/complejoController.dart';
import 'package:futbolito_app/ui/cancha/canchaPage.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/drawer.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:futbolito_app/ui/globales/ui/hidden_scroll_behavior.dart';

class HomePage extends StatefulWidget {
  final userPercistence;
  HomePage(this.userPercistence);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoadingServices=true;
  var dataComplejos;

  Future _getDataCompeljos()async{
    var response = await complejoController().getCompeljos();
    setState(() {
      dataComplejos = response;
      _isLoadingServices=false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataCompeljos();
  }

  @override
  Widget build(BuildContext context) {
    final _appBar=  AppBar(
        backgroundColor: Colores.primaryColor,
        centerTitle: true,
        title: Text('FUTBOLITO')
    );
    final listComplejos =  Container(
      child: Scrollbar(
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            itemCount: dataComplejos==null ? 0: dataComplejos.length,
            itemBuilder: (BuildContext context, i){
              return Complejo(
                  'https://www.britanico.edu.pe/blog/wp-content/uploads/2017/10/vocabulario-ingles-britanico-futbol-800x400.jpg',
                  dataComplejos[i]
              );
            }
        ),
      )
    );
    var erroInternet=Center(
      child: Text(
        'No hay Coneción a internet :(',
        style: TextStyle(
            color: Colors.white,
            fontSize: 20
        ),
      ),
    );
    return Scaffold(
      appBar: _appBar,
      drawer: DrawerPage.drawer(context, widget.userPercistence),
      body: Stack(
        children: [
          Widgets.wallpaper,
          this._isLoadingServices?Center(child: CircularProgressIndicator(),):
              this.dataComplejos[0]['nombre_complejo']=='-1'?erroInternet :
          SafeArea(
            child: ScrollConfiguration(
              behavior: HiddenScrollBehavior(),
              child: listComplejos
            ),
          ),
        ],
      ),
    );
  }
  Widget Complejo(String _image, Map data){
    final startPaint= Expanded(
      child: Icon(
        FontAwesomeIcons.solidStar,
        color: Colores.colorYellow,
        size: 15,
      ),
    );
    final startNotPaint= Expanded(
      child: Icon(
        FontAwesomeIcons.star,
        color: Colores.colorYellow,
        size: 15,
      ),
    );
    List<Widget> stars=[];
    for(int i=0; i<5; i++){
      if(i<data['puntuacion_complejo']){
        stars.add(startPaint);
      }else{
        stars.add(startNotPaint);
      }
    }

    final _TitleComplejo=Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(data['nombre_complejo'],
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colores.primaryColor,
            fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );

    final _puntuacion =Container(
      margin: EdgeInsets.only(top: 10, right: 50, left: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: stars
      ),
    );

    final _Phone= Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 1),
            child: Icon(CupertinoIcons.phone, color: Colores.primaryColor, size: 15,),
          ),
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Text(data['telefono_complejo'], style: TextStyle(color: Colors.white, fontSize: 10),),
          ),
        ],
      ),
    );

    final _Adress=Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 1),
            child: Icon(CupertinoIcons.location, color: Colores.primaryColor, size: 15,),
          ),
          Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(data['direccion_complejo'], style: TextStyle(color: Colors.white, fontSize: 10),),
                  )
                ],
              )
          )
        ],
      ),
    );
    final _Container= Container(
        padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _TitleComplejo,
            _puntuacion,
            _Phone,
            _Adress
          ],
        )
    );

    final _Image= Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.blue),
        gradient: Colores.primaryGradient
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/complejoLoad.gif',
          image: _image,
          fit: BoxFit.cover,
        ),
      )
    );

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: InkWell(
        child: Stack(
            children: [
              _Image,
              _Container
            ]
        ),
        onTap: (){
          Navigator.push(context, CupertinoPageRoute(
              builder: (BuildContext context)=> CanchaPage(data,_image)
          ));
        },
      ),
    );
  }
}


