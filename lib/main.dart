import 'package:flutter/material.dart';
import 'package:neacti/screens/donate.dart';
import 'package:neacti/screens/composer.dart';
import 'package:neacti/models/user.dart';
import 'package:neacti/screens/plans.dart';
import 'package:neacti/screens/wrapper.dart';
import 'package:neacti/services/auth.dart';
import 'package:provider/provider.dart';
import 'screens/profil.dart';
import 'screens/invite.dart';
import 'screens/join.dart';
import 'screens/donate.dart';

void main() => runApp(Neacti());

 class Neacti extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
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








class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [Profil(), Invite(), Join(), Donate()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(context: context),
        backgroundColor: Colors.blueGrey[50],
        body: _children[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black87,
          selectedLabelStyle:
              TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          fixedColor: Colors.red,
          iconSize: 30,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Me'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_location),
              title: Text('Invite'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_add),
              title: Text('Join'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on),
              title: Text('Donate'),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
