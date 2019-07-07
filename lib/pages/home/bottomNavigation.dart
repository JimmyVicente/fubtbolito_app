import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futbolito_app/pages/reserva/reservaPage.dart';
import 'package:futbolito_app/pages/event/eventPage.dart';
import 'package:futbolito_app/pages/home/homePage.dart';
import 'package:futbolito_app/pages/signin/signin.dart';


class BottomNavigation extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Futbolito',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
      routes: {
        '/':(context)=> Tabs(),
        '/siging':(context)=> SignInPageWidget(),
      },
    );
  }
}

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: DefaultTabController(
        length: 3,
        child: new Scaffold(
          body: TabBarView(
            children: <Widget>[
              HomePage(),
              ReservaPage(),
              EventPage(),
            ],
          ),
          bottomNavigationBar: PreferredSize(
            preferredSize: Size(60.0, 60.0),
            child: Container(
              height: 60.0,
              child: TabBar(
                labelColor: Theme.of(context).toggleableActiveColor,
                labelStyle: TextStyle(fontSize: 10.0),
                tabs: <Widget>[
                  Tab(
                    icon: new Icon(FontAwesomeIcons.home),
                    text: 'Inicio',
                  ),
                  Tab(
                    icon: new Icon(FontAwesomeIcons.folder),
                    text: 'Reservas',
                  ),
                  Tab(
                    icon: new Icon(Icons.event),
                    text: 'Noticias',
                  ),
                ],
              ),
            ),
          ),
        ),
    ),

    );
  }
}
