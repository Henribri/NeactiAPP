import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'composer.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Center(
              child: CircleAvatar(

                backgroundColor: Colors.black,
                radius: 55,
              )

          ),
          SizedBox(height: 10),
          Divider(
            indent: 120,
            endIndent: 120,
            color: Colors.redAccent[400],
            thickness: 5,


          ),
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text("Briaux",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Cali',

                  ),
              ),
            ],
          ),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Text("Henri",
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Cali'
            ),
          ),
          ]
        ),
          Divider(
            indent: 0,
            endIndent: 300,
            color: Colors.redAccent[400],
            thickness: 3,


          ),
          SizedBox(height: 15,),

          Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Icon(Icons.mail,color: Colors.redAccent[400])
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                  child: Text("henri.briaux@viacesi.fr ",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Cali',

                    ),
                  ),
                )]
          ),

          SizedBox(height: 15,),

          Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Icon(Icons.play_circle_filled,color: Colors.redAccent[400])
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                  child: Text("Nombre d'activités prévues : 0",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Cali',

                    ),
                  ),
                )]
          ),
          SizedBox(height: 15,),
          Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Icon(Icons.star,color: Colors.redAccent[400])
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                  child: Text("Débutant",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Cali',

                    ),
                  ),
                )]
          ),


          SizedBox(height: 40,),
          Container(
            color: Colors.redAccent[400],
            height: 50,
            width: 200,
            child: FlatButton(
              onPressed: (){Navigator.pushNamed(context,'/plans' );},
              child: Center(
                child: Text(
                  'Mes plans',
                  style: TextStyle(
                    fontFamily: 'Cali',
                    letterSpacing: 2,
                    color: Colors.white,
                    fontSize: 30
                  ),
                ),
              ),
            ),

          )
        ],
      ),
    );
  }
}
