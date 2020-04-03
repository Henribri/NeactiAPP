import 'package:flutter/material.dart';
import 'composer.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: MainDrawer(context:context),
      appBar: MainAppBar(context:context),


    );
  }
}
