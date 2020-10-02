import 'package:flutter/material.dart';
import 'package:neacti/models/apiUrl.dart';
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  String url = ApiUrl.apiUrl;

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
          ],
        ),
      ),

    );
  }
}
