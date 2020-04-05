import 'package:flutter/material.dart';
import 'package:neacti/composer.dart';
class Plans extends StatefulWidget {
  @override
  _PlansState createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.videogame_asset, size: 40, color: Colors.red,),
                    title: Text('Tournoi Smash'),
                    subtitle: Text('7 rue du marais'),
                    trailing: Text('12-05-19')
                  ),

        ButtonBar(
          children: <Widget>[
            FlatButton(
                color: Colors.red,
                child: Text('More'),
                onPressed: () {

                },
            )
]),


                ],
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                child: ExpansionTile(
                  title: Text('Birth of Universe'),
                  children: <Widget>[
                    Text('Big Bang'),
                    Text('Birth of the Sun'),
                    Text('Earth is Born'),
                  ],
                ),
              ),
            )

          ],
        ),
      ),

    );
  }
}
