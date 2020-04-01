import 'package:flutter/material.dart';
import 'tools.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: mydrawer(context).drawer,
      appBar: myappbar(context).mybar,


    );
  }
}
