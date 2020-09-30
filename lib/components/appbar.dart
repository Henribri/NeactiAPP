import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neacti/services/auth.dart';

class NeaAppBar extends StatelessWidget implements PreferredSizeWidget{

  final AuthService _auth = AuthService();
  int selectedIndex;

  NeaAppBar({@required this.selectedIndex});

  final List<String> _windowName = [
    'Neacti',
    'Mes plans',
    'Inviter',
    'Rejoindre',
    //'Aider Neacti'
  ];

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,

      actions: <Widget>[
        IconButton(
          onPressed: () async {
            await _auth.signOut();
          },
          icon: Icon(
            FontAwesomeIcons.signOutAlt,
            color: Color(0xffff4b5c),
            size: 30,
          ),
        )
      ],
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(_windowName[selectedIndex],
            style: TextStyle(
                color: Color(0xffff4b5c),
                fontSize: 26.0,
                fontFamily: 'Fred')),
      ),
      backgroundColor: Color(0xfff6f6f6),
    );
  }
}



