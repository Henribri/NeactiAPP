import 'package:flutter/material.dart';
import 'package:neacti/donate.dart';
import 'package:neacti/composer.dart';
import 'profil.dart';
import 'invite.dart';
import 'join.dart';
import 'donate.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
  '/home':(context)=>Home(),

},
));



class Home extends StatefulWidget {
  @override

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final List<Widget> _children = [
    Profil(),
    Invite(),
    Join(),
    Donate()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(context: context),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: _children[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(

        unselectedItemColor: Colors.black87,

        selectedLabelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),

        fixedColor: Colors.red,
        iconSize: 30,

        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Me'),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location),
            title: Text('Invite'),
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.group_add),
            title: Text('Join'),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            title: Text('Donate'),
          ),

        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      )
    );
  }
}







