import 'package:flutter/material.dart';
import 'profil.dart';
import 'invite.dart';
import 'join.dart';
import 'main.dart';


class mydrawer {

  Drawer drawer;
  mydrawer(BuildContext context){

    this.drawer = Drawer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
        children: <Widget>[
          DrawerHeader(
            child:Text(
              'Let\'s \nmove',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Fred',
                  letterSpacing: 10
              ),
            ),
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Colors.pink,
                    Colors.redAccent[400],
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          ListTile(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder:(context)=>Profile()),
              );
            },
            leading: Icon(Icons.account_circle, color: Colors.red, size: 40),
            title: Text('Profil',
                style: TextStyle(fontSize: 26)),
          ),
          SizedBox(height: 10),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Invite()),
              );
            },
            leading: Icon(Icons.add_location, color: Colors.red, size: 40),
            title: Text('Invite',
                style: TextStyle(fontSize: 26)),
          ),
          SizedBox(height: 10),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Join()),
              );
            },
            leading: Icon(Icons.group, color: Colors.red, size: 40),
            title: Text('Join',
                style: TextStyle(fontSize: 26)),
          ),
          SizedBox(height: 10),
          ListTile(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder:(context)=>Profile()),
              );
            },
            leading: Icon(Icons.settings, color: Colors.red, size: 40),
            title: Text('Settings',
                style: TextStyle(fontSize: 26)),

          ),
          SizedBox(height: 10),
          ListTile(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder:(context)=>Profile()),
              );
            },
            leading: Icon(Icons.monetization_on, color: Colors.red, size: 40),
            title: Text('Donate',
                style: TextStyle(fontSize: 26)),
          )
        ],
      ),

    );

  }

}


class myappbar{
  PreferredSize mybar;

  myappbar(BuildContext context){
    this.mybar=PreferredSize(
      preferredSize: Size.fromHeight(70),
      child: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Colors.pink,
                  Colors.redAccent[400],
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child:FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder:(context)=>Home()),
              );
            },
            child: Text('Neacti',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  letterSpacing: 5.0,
                  fontFamily: 'Fred',
                )
            ),
          ),
        ),


        backgroundColor: Colors.red,
      ),
    );
  }
}