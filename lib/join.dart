import 'package:flutter/material.dart';
import 'composer.dart';
import 'package:http/http.dart';
import 'event_list.dart';
import 'dart:convert';

class Join extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> {

  EventList _eventList= EventList();
  void setEvent() async{

    _eventList.getData();

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
                        'Title',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                      subtitle: Text('Subtitle',
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
                              Text('15-12-2020',
                                style: TextStyle(
                                    fontSize: 18
                                ),),
                              SizedBox(width: 30,),
                              Icon(Icons.access_time, size: 30,),
                              SizedBox(width: 10,),
                              Text('08:03',
                                style: TextStyle(
                                    fontSize: 18
                                ),),
                              SizedBox(width: 30,),
                              Icon(Icons.group, size: 30,),
                              SizedBox(width: 10,),
                              Text('10/15',
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
                              Text('adresse',
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
                                  child: Text('description',
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

