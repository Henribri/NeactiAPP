import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neacti/models/apiUrl.dart';
import 'package:neacti/services/auth.dart';
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  String url = ApiUrl.apiUrl;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xffff4b5c),),

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
              },
              child: Container(
                width: MediaQuery.of(context).size.width-50,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Se déconnecter', style: TextStyle(fontSize: 18, fontFamily: 'Rob',color: Color(0xff056674)),),
                        Icon(FontAwesomeIcons.signOutAlt, size: 20, color: Color(0xff056674),)
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
