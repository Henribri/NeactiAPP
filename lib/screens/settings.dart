import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neacti/models/apiUrl.dart';
import 'package:neacti/services/auth.dart';


class Settings extends StatefulWidget {

  VoidCallback changeTheme;
  Settings({@required this.changeTheme});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String url = ApiUrl.apiUrl;

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(backgroundColor: Theme.of(context).primaryColor,),

      body: Center(
        child: Column(
          children: [
            Container(
              width: 200,
              child: TextField(
                onChanged: (value){
                  url=value;

                },

              ),
            ),
            FlatButton(
              child: Text('Changed'),
              color: Colors.red,
              onPressed: (){
                setState(() {
                  ApiUrl().setUrl(url);
                });
              },
            ),

            SizedBox(height: 50,),
            Text(ApiUrl.apiUrl),



            FlatButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width-50,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Se déconnecter', style:  Theme.of(context).textTheme.headline3,),
                        Icon(FontAwesomeIcons.signOutAlt, size: 20, color: Theme.of(context).primaryColorDark,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            FlatButton(
              onPressed: () {
                widget.changeTheme();
              },
              child: Container(
                width: MediaQuery.of(context).size.width-50,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Changer de theme', style:  Theme.of(context).textTheme.headline3,),
                        Icon(Icons.wb_sunny, size: 20, color: Theme.of(context).primaryColorDark,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
