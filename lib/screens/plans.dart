import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:neacti/models/user.dart';
import 'package:flutter/cupertino.dart';
import '../models/event.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

class Plans extends StatefulWidget {
  @override
  _PlansState createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  //-- RETURN LIST OF PLANS --
  Future<List<Event>> _getData(String userId) async {
    Response response =
        await get('http://10.0.2.2:8000/events/user_registered/$userId.json');
    List<dynamic> data = jsonDecode(response.body);

    return data.map((i) => Event.fromJson(i)).toList();
  }

  // Put method to remove people
  _putLeaveEvent(String eventId, Map body) async {
    String url = 'http://10.0.2.2:8000/events/$eventId/';
    Map<String, String> headers = {"Content-type": "application/json"};
    Response response =
        await put(url, headers: headers, body: json.encode(body));
    int statusCode = response.statusCode;
    print(statusCode);
  }

  // Variable to contain the list of User registered for the event
  var registeredPeople = new Map<String, List<String>>();

  //-- BUILD PLANS PAGE
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(210, 255, 0, 60),
          title: Text(
            'Mes plans',
            style: TextStyle(
                color: Colors.white, fontFamily: 'Fred', fontSize: 26),
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(
              Icons.search,
              size: 40,
              color: Colors.white,
            )),
          ],
        ),
        backgroundColor: Colors.blueGrey[50],
        body: Container(
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
                              backgroundColor: Colors.redAccent,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.deepPurpleAccent),
                              strokeWidth: 5)));
                } else if (listEvent.data.length == 0) {
                  return Container(
                    child: Center(
                      child: Text(
                        "Vous n'avez pas d'event.",
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
                                    fontFamily: listEvent
                                        .data[index].category.fontFamily,
                                    fontPackage: listEvent
                                        .data[index].category.fontPackage),
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
                                    child: Text('Leave'),
                                    onPressed: () {
                                      // Remove the user from the list of registered
                                      listEvent.data[index].actPeople
                                          .removeWhere((item) =>
                                              item ==
                                              Provider.of<User>(context).uid);

                                      // Map it for the request
                                      registeredPeople["act_people"] =
                                          listEvent.data[index].actPeople;

                                      // Call request ti update the new list of user
                                      _putLeaveEvent(listEvent.data[index].id,
                                          registeredPeople);

                                      setState(() {
                                        // Alert of leaving an event
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor: Colors.greenAccent,
                                          content: Text(
                                            'The event has been removed from your plans',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
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
        ));
  }
}
