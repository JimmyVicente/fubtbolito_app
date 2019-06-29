import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/complejo/complejoPage.dart';
import 'package:futbolito_app/complejo/mapaComplejo.dart';
import 'homePage.dart';

class BottomNavigation extends StatefulWidget {
  @override  _BottomNavigation createState() => new _BottomNavigation();
}

class _BottomNavigation extends State<BottomNavigation> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _children = [
    new HomePage(),
    new ComplejoPage(),
    new MapaComplejo()
  ];

  @override  Widget build(BuildContext context) {

    final _FloatingActionButton=FloatingActionButton(
        child: Icon(Icons.add_location, color: Colors.blueAccent,size: 50,),
        backgroundColor: Colors.white,
        onPressed: (){
//          Navigator.push(context, MaterialPageRoute(
//              builder: (BuildContext context)=> NewEventPage()
//          ));
        }
    );
    return new Scaffold(
        body: _children[_currentIndex],
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //  floatingActionButton: _FloatingActionButton,
        bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: new Icon(CupertinoIcons.home),
                  title: new Text('Inicio')
              ),
              BottomNavigationBarItem(
                  icon: new Icon(Icons.account_balance),
                  title: new Text('Complejos')
              ),
              BottomNavigationBarItem(
                  icon: new Icon(Icons.map),
                  title: new Text('Mapa')
              ),
            ]
        )
    );

  }
}