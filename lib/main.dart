import 'package:flutter/material.dart';
import 'package:neacti/screens/donate.dart';
import 'package:neacti/models/user.dart';
import 'package:neacti/screens/pageBasis.dart';
import 'package:neacti/screens/plans.dart';
import 'package:neacti/screens/settings.dart';
import 'package:neacti/screens/wrapper.dart';
import 'package:neacti/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() => runApp(Neacti());

class Neacti extends StatelessWidget {


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
          '/home': (context) => PageBasis(),
          '/plans': (context) => Plans(),
          '/profil/settings':(context)=>Settings(),


        },


        /// Manage color in the app
        theme: ThemeData(
          primaryColor: Color(0xffff4b5c) ,
          primaryColorDark: isDark == true ? Color(0xff404b69) : Color(0xff283149),
          primaryColorLight: isDark == true ? Colors.white : Color(0xff283149),
          backgroundColor:  isDark == true ? Color(0xff283149) : Colors.white,

          //0xff283149 = dark background
            // 0xff404b69
          buttonColor: isDark == true ? Color(0xff404b69) : Color(0xfff6f6f6),

          fontFamily: 'Rob',

          textTheme: TextTheme(
            headline1: TextStyle(
                color: Color(0xffff4b5c),
                fontSize: 26.0,
                fontFamily: 'Fred'),

            //=light Color
            headline2: TextStyle(
                color: isDark == true ? Colors.white : Color(0xff283149), fontSize: 26, fontFamily: 'Rob'),

            //=dark Color
            headline3: TextStyle(fontSize: 18, fontFamily: 'Rob',color: isDark == true ? Color(0xff404b69) : Color(0xff283149),),

            //= dark Color
            headline4: TextStyle(fontSize: 20, color: isDark == true ? Colors.white : Color(0xff283149),)

          )

        ),
      ),
    );
  }
}
