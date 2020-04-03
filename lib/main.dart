import 'package:flutter/material.dart';
import 'package:neacti/donate.dart';
import 'package:neacti/settings.dart';
import 'package:neacti/composer.dart';
import 'profil.dart';
import 'invite.dart';
import 'join.dart';
import 'donate.dart';
import 'settings.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
  '/home':(context)=>Home(),
  '/profil':(context)=>Profil(),
  '/invite':(context)=>Invite(),
  '/join':(context)=>Join(),
  '/settings':(context)=>Settings(),
  '/donate':(context)=>Donate(),

},
));


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: MainDrawer(context: context),
      appBar: MainAppBar(context: context),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin:EdgeInsets.fromLTRB(0,10,0,0),
                  color: Colors.redAccent[400],
                  child:Center(
                    child: Text(
                      'Bienvenue que voulez vous faire',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cali',
                        letterSpacing: 3,

                      ),
                    ),
                  )
                ),
              )
            ],
          ),

          SizedBox(height: 60),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                    onPressed: (){Navigator.pushNamed(context, '/invite');},
                    color: Colors.redAccent[400],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),

                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30),
                        side: BorderSide(color: Colors.redAccent),

                    ),
                    child: Center(
                      child: Text('Inviter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Fred',
                            letterSpacing: 2
                          )),
                    )
                ),
              ),
            ]),
          SizedBox(height: 40,),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                Expanded(
                  child: FlatButton(
                      onPressed: (){Navigator.pushNamed(context, '/join');},
                      color: Colors.redAccent[400],
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),

                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30),
                        side: BorderSide(color: Colors.redAccent),

                      ),
                      child: Center(
                        child: Text('Rejoindre',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Fred',
                              letterSpacing: 2
                            )),
                      )
                  ),
                ),
              ]),


        ],
      ),
    );
  }
}




