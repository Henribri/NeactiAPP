import 'package:flutter/material.dart';
import 'package:neacti/components/appbar.dart';
import 'package:neacti/components/navbar.dart';
import 'profil.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  /// Index and page
  int selectedIndex =0;
  Widget currentPage=Profil();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff6f6f6),

        appBar: NeaAppBar(selectedIndex: selectedIndex),

        body: currentPage,

        bottomNavigationBar: NeaNavBar(
          selectedIndex: selectedIndex,
          selectedPage: (int newIndex, Widget newPage){
            setState(() {
              currentPage=newPage;
              selectedIndex=newIndex;
            });
          },
        )
    );

  }
}



