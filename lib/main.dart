import 'package:flutter/material.dart';
import 'package:neacti/screens/donate.dart';
import 'package:neacti/screens/composer.dart';
import 'package:neacti/models/user.dart';
import 'package:neacti/screens/home.dart';
import 'package:neacti/screens/plans.dart';
import 'package:neacti/screens/wrapper.dart';
import 'package:neacti/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() => runApp(Neacti());

class Neacti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Stream provider to listen if there is any change of user state
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/wrapper',
        routes: {
          '/wrapper': (context) => Wrapper(),
          '/home': (context) => Home(),
          '/plans': (context) => Plans(),
        },
      ),
    );
  }
}
