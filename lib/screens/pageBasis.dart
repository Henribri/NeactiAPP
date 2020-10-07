import 'package:flutter/material.dart';
import 'package:neacti/components/appbar.dart';
import 'package:neacti/components/navbar.dart';
import 'home.dart';


class PageBasis extends StatefulWidget {
  @override
  _PageBasisState createState() => _PageBasisState();
}

class _PageBasisState extends State<PageBasis> {

  /// Index and page
  int selectedIndex =0;
  Widget currentPage=Home();



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



