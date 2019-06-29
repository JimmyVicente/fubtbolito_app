import 'package:flutter/material.dart';
import 'package:futbolito_app/data/base_api.dart';

class ComplejoPage extends StatefulWidget {
  @override
  _ComplejoPageState createState() => _ComplejoPageState();
}

class _ComplejoPageState extends State<ComplejoPage> {
  bool _isLoadingServices=true;

  List dataComplejos;

  Future<String> getComplejo() async{
    BaseApi _baseApi = new BaseApi();
    final response = await _baseApi.get('http://10.20.0.173:8000/complejos');
    if (response['count']!=0) {
      setState(() {
        dataComplejos= response['results'];
        print(dataComplejos[0]);
        _isLoadingServices = false;
      });
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    getComplejo();
  }
  @override
  Widget build(BuildContext context) {
    final _appBar=  AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Complejos')
    );
    final listComplejos =  Container(
      padding: EdgeInsets.only(left: 20, top: 60, right: 20,),
      child: ListView.builder(
          itemCount: dataComplejos==null ? 0: dataComplejos.length,
          itemBuilder: (BuildContext context, i){
            return new  Container(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: ListTile(
                      title: Center(child: Text(dataComplejos[i]['nombre_complejo'])),
                      subtitle: Center(child: Text(dataComplejos[i]['telefono_complejo']),),
                    )
                )
            ); //Container
          }
      ),
    );


    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: _appBar,
        body: Stack(
          children: <Widget>[
            this._isLoadingServices
                ? Center(
              child: CircularProgressIndicator(),
            ):
            listComplejos
          ],
        )
    );
  }
}
