import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neacti/screens/composer.dart';
import 'package:neacti/services/auth.dart';
import 'profil.dart';
import 'invite.dart';
import 'join.dart';
import 'donate.dart';
import 'package:neacti/models/user.dart';
import 'package:neacti/screens/home.dart';
import 'package:neacti/screens/plans.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  int selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> _children = [Profil(), Plans(), Invite(), Join(), Donate()];
  final List<String> _windowName = ['Neacti', 'Mes plans', 'Inviter', 'Rejoindre', 'Aider Neacti'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          elevation: 2,
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Color(0xffff4b5c),
                size: 30,

              ),
            )
          ],

          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(_windowName[selectedIndex],
                style: TextStyle(
                  color: Color(0xffff4b5c),
                  fontSize: 26.0,
                  fontFamily: 'Fred'

                )),
          ),
          backgroundColor: Color(0xfff6f6f6),
        ),
        backgroundColor: Color(0xfff6f6f6),
        body: _children[selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
          height: 50.0,
          items: <Widget>[
            Icon(Icons.home, color: Colors.white, size: 30),
            Icon(Icons.favorite, color: Colors.white, size: 30),
            Icon(Icons.add_location, color: Colors.white, size: 30),
            Icon(Icons.group_add, color: Colors.white ,size: 30),
            Icon(Icons.monetization_on,  color: Colors.white,size: 30),
          ],
          color: Color(0xffff4b5c),
          buttonBackgroundColor: Color(0xffff4b5c),
          backgroundColor: Color(0xfff6f6f6),
          animationDuration: Duration(milliseconds: 300),


          index: selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
