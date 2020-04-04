import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'composer.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 55,
                )

            ),
            SizedBox(height: 10),
            Divider(
              indent: 100,
              endIndent: 100,
              color: Colors.black,
              thickness: 5,


            ),
            Row(
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text("Briaux",
                    textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Cali'
                      ),
                  ),
                ),
              ],
            ),
        Row(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text("Henri",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Cali'
                ),
              ),
            )]
          )
          ],
        ),
        color: Colors.blue[100],


      ),
    );
  }
}
