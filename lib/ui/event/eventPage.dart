import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:futbolito_app/ui/globales/colors.dart';
import 'package:futbolito_app/ui/globales/drawer.dart';
import 'package:futbolito_app/ui/globales/widget.dart';
import 'package:futbolito_app/ui/globales/ui/hidden_scroll_behavior.dart';

class EventPage extends StatefulWidget {
  final userPercistence;
  EventPage(this.userPercistence);

  @override
  _eventPageState createState() => _eventPageState();
}

class _eventPageState extends State<EventPage> {

  @override
  Widget build(BuildContext context) {
    final _appBar=  AppBar(
        backgroundColor: Colores.primaryColor,
        centerTitle: true,
        title: Text('NOTICIAS')
    );
    return Scaffold(
      appBar: _appBar,
      drawer: DrawerPage.drawer(context, widget.userPercistence),
      body: Stack(
        children: [
          Widgets.wallpaper,
          Center(
            child: ScrollConfiguration(
              behavior: HiddenScrollBehavior(),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(20),
                children: [

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
