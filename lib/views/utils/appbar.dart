import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'file:///C:/Users/henri/AndroidStudioProjects/neacti/lib/buisness_logic/services/auth.dart';

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
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,

      actions: <Widget>[
        IconButton(
          icon: Icon(
            FontAwesomeIcons.commentDots,
            color: Theme.of(context).primaryColor,

            size: 30,
          ),
        )
      ],
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(_windowName[selectedIndex],
            style: Theme.of(context).textTheme.headline1),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}



