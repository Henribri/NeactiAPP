import 'package:flutter/material.dart';
import 'composer.dart';
import 'event.dart';

class Join extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> {

  Event _event= Event();
  void setEvent() async{
    await _event.getData();
    setState(() {

    });
  }

  @override
  void initState(){
    super.initState();
    setEvent();
  }


  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          backgroundColor: Colors.white,
          pinned: true,
          expandedHeight: 70,
          elevation: 10,

          title: Text('Filtre : Tous',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.red,
            ),),


        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, size: 40, color: Colors.red,),
            tooltip: 'Add new entry',

          ),
        ],),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: 10,),
              Card(
                child: Column(
                  children: <Widget>[
                    ExpansionTile(
                      leading: Icon(
                        Icons.videogame_asset, size: 40, color: Colors.red,),
                      title: Text(
                        _event.title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                      subtitle: Text(_event.message,
                        style: TextStyle(
                            fontSize: 16
                        ),),

                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 5),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.date_range, size: 30,),
                              SizedBox(width: 10,),
                              Text(_event.date,
                                style: TextStyle(
                                    fontSize: 18
                                ),),
                              SizedBox(width: 30,),
                              Icon(Icons.access_time, size: 30,),
                              SizedBox(width: 10,),
                              Text(_event.time,
                                style: TextStyle(
                                    fontSize: 18
                                ),),
                              SizedBox(width: 30,),
                              Icon(Icons.group, size: 30,),
                              SizedBox(width: 10,),
                              Text(_event.group,
                                style: TextStyle(
                                    fontSize: 18
                                ),),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.location_on, size: 30,),
                              SizedBox(width: 10,),
                              Text(_event.address,
                                style: TextStyle(
                                  fontSize: 18,

                                ),),
                            ],
                          ),
                        ),

                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.description, size: 30,),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Container(
                                  child: Text(_event.desc,
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 18
                                    ),),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                color: Colors.red,
                                child: Text('Join'),
                                onPressed: () {

                                },
                              ),


                            ]),

                      ],
                    ),


                  ],
                ),
              ),


                  SizedBox(height: 10,),
              Card(
                child: Column(
                  children: <Widget>[
                    ExpansionTile(
                      leading: Icon(
                        Icons.videogame_asset, size: 40, color: Colors.red,),
                      title: Text(
                        'Tournoi Smash',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                      subtitle: Text('Ramenez vos manettes !',
                        style: TextStyle(
                            fontSize: 16
                        ),),

                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 5),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.date_range, size: 30,),
                              SizedBox(width: 10,),
                              Text('12-05-2020',
                                style: TextStyle(
                                    fontSize: 18
                                ),),
                              SizedBox(width: 30,),
                              Icon(Icons.access_time, size: 30,),
                              SizedBox(width: 10,),
                              Text('16:30',
                                style: TextStyle(
                                    fontSize: 18
                                ),),
                              SizedBox(width: 30,),
                              Icon(Icons.group, size: 30,),
                              SizedBox(width: 10,),
                              Text('10/14',
                                style: TextStyle(
                                    fontSize: 18
                                ),),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.location_on, size: 30,),
                              SizedBox(width: 10,),
                              Text('7 rue du marais',
                                style: TextStyle(
                                  fontSize: 18,

                                ),),
                            ],
                          ),
                        ),

                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.description, size: 30,),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Container(
                                  child: Text('Description',
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 18
                                    ),),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                color: Colors.red,
                                child: Text('Join'),
                                onPressed: () {

                                },
                              ),


                            ]),

                      ],
                    ),


                  ],
                ),
              ),
            ]
          ),
        ),

      ],
    );
  }
}

