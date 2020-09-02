import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:neacti/models/user.dart';
import 'package:flutter/cupertino.dart';
import '../models/event.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Join extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> {
  //-- RETURN LIST OF ACTUAL EVENT --
  Future<List<Event>> _getData(String userId) async {
    Response response = await get(
        'http://10.0.2.2:8000/events/user_not_registered/$userId.json');
    List<dynamic> data = jsonDecode(response.body);

    return data.map((i) => Event.fromJson(i)).toList();
  }



  // Put method to add people
  _putJoinEvent(String eventId, Map body) async {
    String url = 'http://10.0.2.2:8000/events/$eventId/';
    Map<String, String> headers = {"Content-type": "application/json"};
    Response response =
        await put(url, headers: headers, body: json.encode(body));
    int statusCode = response.statusCode;
    print(statusCode);
  }

  // Variable to contain the list of User registered for the event
  var registeredPeople = new Map<String, List<String>>();

  //-- BUILD JOIN PAGE
  @override
  Widget build(BuildContext context) {
    return Container(
      //-- GET THE DATA TO DISPLAY
      child: FutureBuilder(
          future: _getData(Provider.of<User>(context).uid),
          builder: (BuildContext context, AsyncSnapshot listEvent) {
            if (listEvent.data == null) {
              //-- IF NO DATA RETURN A CIRCLE WAIT
              return Center(
                  child: Container(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                          backgroundColor: Color(0xffe8505b),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xff14b1ab)),
                          strokeWidth: 5)));
            }
            // IF there is no event display a message
            else if (listEvent.data.length == 0) {
              return Container(
                child: Center(
                  child: Text(
                    "Pas d'event pour le moment.",
                    style: TextStyle(fontFamily: 'Fred', fontSize: 26),
                  ),
                ),
              );
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
                            IconData(listEvent.data[index].category.iconId,
                                fontFamily:
                                    listEvent.data[index].category.fontFamily,
                                fontPackage:
                                    listEvent.data[index].category.fontPackage),
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
                                    listEvent.data[index].actPeople.length
                                            .toString() +
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
                                  Flexible(
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed:() async {
                                        // Launch google map url
                                        String lat = listEvent.data[index].address.lat.toString();
                                        String lon = listEvent.data[index].address.lon.toString();
                                        String placeId = listEvent.data[index].address.placeId.toString();
                                        String url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon&query_place_id=$placeId';
                                        if (await canLaunch(url)) {
                                        launch(url);
                                        } else {
                                        throw 'Could not launch $url';
                                        }
                                    },
                                      child: Text(
                                        listEvent.data[index].address.name,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
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
                                  Flexible(
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
                                onPressed: () {
                                  // Add the user from the list of registered
                                  listEvent.data[index].actPeople
                                      .add(Provider.of<User>(context).uid);

                                  // Map it for the request
                                  registeredPeople["act_people"] =
                                      listEvent.data[index].actPeople;

                                  // Call request ti update the new list of user
                                  _putJoinEvent(listEvent.data[index].id,
                                      registeredPeople);

                                  setState(() {
                                    // Alert of joining an event
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      backgroundColor: Colors.greenAccent,
                                      content: Text(
                                        'The event has been add to your plans',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      duration: Duration(seconds: 1),
                                    ));
                                  });
                                },
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
