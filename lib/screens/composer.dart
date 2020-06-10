import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neacti/models/user.dart';
import 'package:neacti/screens/join.dart';
import 'package:neacti/services/auth.dart';
import 'package:provider/provider.dart';



class MainDrawer extends StatelessWidget {

  final BuildContext context;

  MainDrawer({this.context});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
        children: <Widget>[
          DrawerHeader(
            child: Text(
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
            onTap: () {
              Navigator.pushNamed(context, '/profil');
            },
            leading: Icon(Icons.account_circle, color: Colors.red, size: 40),
            title: Text('Me',
                style: TextStyle(fontSize: 26)),
          ),
          SizedBox(height: 10),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/invite');
            },
            leading: Icon(Icons.add_location, color: Colors.red, size: 40),
            title: Text('Invite',
                style: TextStyle(fontSize: 26)),
          ),
          SizedBox(height: 10),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/join');
            },
            leading: Icon(Icons.group, color: Colors.red, size: 40),
            title: Text('Join',
                style: TextStyle(fontSize: 26)),
          ),
          SizedBox(height: 10),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
            leading: Icon(Icons.settings, color: Colors.red, size: 40),
            title: Text('Settings',
                style: TextStyle(fontSize: 26)),

          ),
          SizedBox(height: 10),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/donate');
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

  class MainAppBar extends StatelessWidget implements PreferredSizeWidget{

  final AuthService _auth = AuthService();

  final BuildContext context;
  MainAppBar({this.context});

  @override
  Size get preferredSize => Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(onPressed: () async{
            await _auth.signOut();
          },

              icon: Icon(FontAwesomeIcons.signOutAlt, color: Colors.white, size: 30,),
          )
        ],
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
                    tileMode: TileMode.clamp
                  ),
                ),
              ),
              title: Align(
                alignment: Alignment.centerLeft,
              child:Text('Neacti',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  letterSpacing: 5.0,
                  fontFamily: 'Fred',
                )
            ),
        ),


        backgroundColor: Colors.red,

      );
    }

  }

