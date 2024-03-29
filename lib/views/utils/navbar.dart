import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/henri/AndroidStudioProjects/neacti/lib/views/invite.dart';
import 'package:neacti/views/actvities.dart';
import 'package:neacti/views/home.dart';
class NeaNavBar extends StatelessWidget {

  /// Index of page
  int selectedIndex;

  /// Function to update the body on main
  final Function(int, Widget) selectedPage;

  /// NavBar constructor
  NeaNavBar({@required this.selectedIndex, this.selectedPage});


  /// List of screen
  final List<Widget> _children = [
    Home(),
    ActivitiesPage(joinPage: false, key: UniqueKey(),),
    Invite(),
    ActivitiesPage(joinPage: true, key : UniqueKey()),
    //Donate()
  ];


  /// Update value
  void _onItemTapped(int index) {
    selectedIndex=index;
    selectedPage(selectedIndex,_children[selectedIndex]);
  }


  /// Nav bar builder
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 50.0,
      items: <Widget>[
        Icon(Icons.home, color: Colors.white, size: 30),
        Icon(Icons.favorite, color: Colors.white, size: 30),
        Icon(Icons.add_location, color: Colors.white, size: 30),
        Icon(Icons.group_add, color: Colors.white, size: 30),
        //Icon(Icons.monetization_on, color: Colors.white, size: 30),
      ],
      color: Color(0xffff4b5c),
      buttonBackgroundColor: Color(0xffff4b5c),
      backgroundColor:  Colors.transparent,
      animationDuration: Duration(milliseconds: 300),
      index: selectedIndex,
      onTap: _onItemTapped,
    );
  }
}