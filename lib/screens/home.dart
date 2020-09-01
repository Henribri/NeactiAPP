import 'package:flutter/material.dart';
import 'package:neacti/screens/composer.dart';
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
  int selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> _children = [Profil(), Invite(), Join(), Donate()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(context: context),
        backgroundColor: Colors.blueGrey[50],
        body: _children[selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
          height: 50.0,
          items: <Widget>[
            Icon(Icons.account_circle, color: Colors.white, size: 30),
            Icon(Icons.add_location, color: Colors.white, size: 30),
            Icon(Icons.group_add, color: Colors.white ,size: 30),
            Icon(Icons.monetization_on,  color: Colors.white,size: 30),
          ],
          color: Colors.redAccent[400],
          buttonBackgroundColor: Colors.redAccent[400],
          backgroundColor: Colors.white,
          animationDuration: Duration(milliseconds: 100),


          index: selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
