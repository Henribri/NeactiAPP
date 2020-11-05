import 'package:flutter/material.dart';
import 'package:neacti/views/utils/appbar.dart';
import 'package:neacti/views/utils/navbar.dart';
import 'home.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  /// Index and page
  int selectedIndex =0;
  Widget currentPage=Home();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,

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



