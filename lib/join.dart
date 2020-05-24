import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import 'package:flutter/cupertino.dart';
import 'event.dart';
import 'dart:convert';

class Join extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> {

  //-- RETURN LIST OF ACTUAL EVENT --
  Future<List<Event>> _getData() async {
    Response response = await get('http://10.0.2.2:8000/events.json');
    List<dynamic> data = jsonDecode(response.body);

   return data.map((i)=>Event.fromJson(i)).toList();

  }


  //-- BUILD JOIN PAGE
  @override
  Widget build(BuildContext context) {
    return Container(
      //-- GET THE DATA TO DISPLAY
      child: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot listEvent) {
            if (listEvent.data == null) {
              //-- IF NO DATA RETURN A CIRCLE WAIT
              return Center(
                  child: Container(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.redAccent,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.deepPurpleAccent),
                          strokeWidth: 5)));
            } else {
              //-- IF WE GET DATA THEN DISPLAY IT
              return ListView.builder(
                itemCount: listEvent.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ExpansionTile(
                          leading: Icon(
                            IconData(listEvent.data[index].category.iconId, fontFamily: listEvent.data[index].category.fontFamily, fontPackage: listEvent.data[index].category.fontPackage),
                                  size: 40,
                                  color: Colors.red,
                                ),
                          title: Text(
                            listEvent.data[index].title,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            listEvent.data[index].subtitle,
                            style: TextStyle(fontSize: 16),
                          ),
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 10, 0, 5),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.date_range,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    DateFormat("dd-MM-yyyy").format(
                                        DateTime.parse(listEvent
                                            .data[index].dateTime
                                            .substring(0, 10))),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Icon(
                                    Icons.access_time,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    listEvent.data[index].dateTime
                                        .substring(11, 16),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Icon(
                                    Icons.group,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    listEvent.data[index].actPeople.length.toString() +
                                        '/' +
                                        listEvent.data[index].allPeople
                                            .toString(),
                                    style: TextStyle(fontSize: 18),
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
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    listEvent.data[index].address,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.description,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        listEvent.data[index].desc,
                                        maxLines: 3,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ButtonBar(children: <Widget>[
                              FlatButton(
                                color: Colors.red,
                                child: Text('Join'),
                                onPressed: () {},
                              ),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
