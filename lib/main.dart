import 'package:flutter/material.dart';
import 'package:neacti/views/donate.dart';
import 'package:neacti/buisness_logic/models/user.dart';
import 'package:neacti/views/mainpage.dart';
import 'package:neacti/views/settings.dart';
import 'package:neacti/views/utils/theme.dart';
import 'package:neacti/views/wrapper.dart';
import 'file:///C:/Users/henri/AndroidStudioProjects/neacti/lib/buisness_logic/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() => runApp(Neacti());

class Neacti extends StatefulWidget {


  @override
  _NeactiState createState() => _NeactiState();
}

class _NeactiState extends State<Neacti> {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    /// Stream provider to listen if there is any change of user state
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/wrapper',
        routes: {
          '/wrapper': (context) => Wrapper(),
          '/home': (context) => MainPage(),
          '/profil/settings':(context)=>Settings(changeTheme: (){
            setState(() {
              isDark=!isDark;
            });
          },),


        },

        /// Manage color in the app
        theme: NeaTheme(isDark)
      ),
    );
  }
}
