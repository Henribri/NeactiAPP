import 'package:flutter/material.dart';
import 'composer.dart';


class Invite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: MainDrawer(context:context),
      appBar: MainAppBar(context: context),


    );
  }
}
