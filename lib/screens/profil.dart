import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'composer.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          /*
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

          )*/

      Card(
      child: ExpansionTile(
        initiallyExpanded: false,
        leading: Icon(
          Icons.library_music,
          size: 40,
          color: Color(0xffff4b5c),),

        title: Text(
          'Sport aved Charles',
          style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff056674),),

        ),
        subtitle: Text(
          'Ceci est un test !!!',
          style: TextStyle(fontSize: 16,color: Color(0xff056674),),

        ),

    children: <Widget>[
    Padding(
    padding: EdgeInsets.fromLTRB(15, 10, 0, 5),
    child: Row(
    children: <Widget>[
    Icon(
    Icons.date_range,
    size: 30,
    color: Color(0xffff4b5c),
    ),
    SizedBox(
    width: 10,
    ),
    Text(
    '02-02-2020',
    style: TextStyle(fontSize: 18, color: Color(0xff056674)),
    ),
    SizedBox(
    width: 30,
    ),
    Icon(
    Icons.access_time,
    size: 30,
    color: Color(0xffff4b5c),
    ),
    SizedBox(
    width: 10,
    ),
    Text(
    '08:10',
    style: TextStyle(fontSize: 18, color: Color(0xff056674)),
    ),
    SizedBox(
    width: 30,
    ),
    Icon(
    Icons.group,
    size: 30,
    color: Color(0xffff4b5c),
    ),
    SizedBox(
    width: 10,
    ),
    Text(
'5/10'
        .toString(),
    style: TextStyle(fontSize: 18, color: Color(0xff056674)),
    ),
    ],
    ),
    ),
    SizedBox(
    height: 10,
    ),
    Padding(
    padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
    child: Row(
    children: <Widget>[
    Icon(
    Icons.location_on,
    size: 30,
    color: Color(0xffff4b5c),
    ),
    SizedBox(
    width: 10,
    ),
    Flexible(
    child: FlatButton(
    padding: EdgeInsets.all(0),
    child: Text(
    'AMiens',
    style: TextStyle(
    fontSize: 18
    , color: Color(0xff056674)
    ),
    ),
    ),
    ),
    ],))


      ,SizedBox(height: 10),
      Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.description,
              size: 30,
              color: Color(0xffff4b5c),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Container(
                child: Text(
                  'lala',
                  maxLines: 3,
                  style: TextStyle(fontSize: 18, color: Color(0xff056674)),
                ),
              ),
            ),
          ],)),
      ButtonBar(children: <Widget>[
        FlatButton(
          color: Color(0xff056674),
          child: Text('Join'),
          onPressed: (){

          },

        ),
      ]),
        ],
      ),
    )
      ]))
    ;
  }
}
