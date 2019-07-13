import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_cupertino_localizations/flutter_cupertino_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futbolito_app/ui/reservation/reservationPage.dart';
import 'package:futbolito_app/ui/event/eventPage.dart';
import 'package:futbolito_app/ui/home/homePage.dart';
import 'package:futbolito_app/ui/signin/signin.dart';


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
        '/home':(context)=> Tabs(),
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('es'), // Español
      ],
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
              ReservationPage(),
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
