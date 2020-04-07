import 'package:flutter/material.dart';
import 'composer.dart';

class Join extends StatelessWidget {
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
                              SizedBox(width: 20,),
                              Text('12-05-2020',
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
                              SizedBox(width: 20,),
                              Text('7 rue du marais',
                                style: TextStyle(
                                  fontSize: 18,

                                ),),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.group, size: 30,),
                              SizedBox(width: 20,),
                              Text('10/14',
                                style: TextStyle(
                                    fontSize: 18
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
                              SizedBox(width: 20,),
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
                              )
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
                              SizedBox(width: 20,),
                              Text('12-05-2020',
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
                              SizedBox(width: 20,),
                              Text('7 rue du marais',
                                style: TextStyle(
                                  fontSize: 18,

                                ),),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.group, size: 30,),
                              SizedBox(width: 20,),
                              Text('10/14',
                                style: TextStyle(
                                    fontSize: 18
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
                              SizedBox(width: 20,),
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

