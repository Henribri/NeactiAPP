import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:neacti/components/flushbar.dart';
import 'package:neacti/models/apiUrl.dart';
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

  /// Return list of actual event
  Future<List<Event>> _getData(String userId) async {
    String apiUrl = ApiUrl.apiUrl;
    Response response = await get(
        'http://$apiUrl/events/user_not_registered/$userId.json');
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    return data.map((i) => Event.fromJson(i)).toList();
  }

  Future<void> _getRefresh() async {
    setState(() {

    });
  }

  /// Put method to add people
  _putJoinEvent(String eventId, Map body) async {
    String apiUrl = ApiUrl.apiUrl;
    String url = 'http://$apiUrl/events/$eventId/';

    Map<String, String> headers = {"Content-type": "application/json"};
    Response response =
        await patch(url, headers: headers, body: json.encode(body));

    if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
      /// Alert error
      NeaFlushBar(flushTitle:"Erreur lors de l'envoi", flushMessage:"~~~~~~~", isError: true).getNeaFlushbar().show(context);
    }else{
      /// Alert the creation of an event
      NeaFlushBar(flushTitle:"Vous avez rejoint une activit\é", flushMessage:"Elle est disponible dans Mes plans", isError: false).getNeaFlushbar().show(context);
      _getRefresh();
    }
  }

  /// Variable to contain the list of User registered for the event
  Map<String, List<String>> registeredPeople = new Map<String, List<String>>();

  /// List to contain actPeople from gotten data
  List<String> newActPeople;

  /// Build join page
  @override
  Widget build(BuildContext context) {
    return Container(
      /// Get the data to display
      child: FutureBuilder(
          future: _getData(Provider.of<User>(context).uid),
          builder: (BuildContext context, AsyncSnapshot listEvent) {
            if (listEvent.data == null) {
              /// If no data return circle
              return Center(
                  child: Container(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                          backgroundColor: Color(0xffff4b5c),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xff056674)),
                          strokeWidth: 5)));
            }

            /// If there is no event display a message
            else if (listEvent.data.length == 0) {
              return RefreshIndicator(
                backgroundColor: Color(0xff056674),
                color: Colors.white,
                onRefresh: _getRefresh,
                child: ListView(
                  children: [
                    SizedBox(height: 200,),
                    Center(
                        child: Text(
                          "Pas d'event pour le moment.",
                          style: TextStyle(fontFamily: 'Fred', fontSize: 26, color: Color(0xff056674)),
                        ),
                      ),


                  ],

                  ),
              );
            } else {

              /// If we get data then display it
              return RefreshIndicator(
                backgroundColor: Color(0xff056674),
                color: Colors.white,
                onRefresh: _getRefresh,
                child: ListView.builder(
                  itemCount: listEvent.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.white,
                      child: ExpansionTile(
                        leading: Icon(
                          IconData(listEvent.data[index].category.iconId,
                              fontFamily:
                                  listEvent.data[index].category.fontFamily,
                              fontPackage:
                                  listEvent.data[index].category.fontPackage),
                          size: 40,
                          color: Color(0xffff4b5c),
                        ),
                        title: Text(
                          listEvent.data[index].title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff056674),),
                        ),
                        subtitle: Text(
                          listEvent.data[index].category.name,
                          style: TextStyle(fontSize: 16, color: Color(0xff056674)),
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
                                  DateFormat("dd-MM-yyyy").format(
                                      DateTime.parse(listEvent
                                          .data[index].dateTime
                                          .substring(0, 10))),
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
                                  listEvent.data[index].dateTime
                                      .substring(11, 16),
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
                                  listEvent.data[index].actPeople.length
                                          .toString() +
                                      '/' +
                                      listEvent.data[index].allPeople
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
                                    onPressed:() async {

                                      /// Launch google map url
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
                                        fontSize: 18
                                        , color: Color(0xff056674)
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
                                  color: Color(0xffff4b5c),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Container(
                                    child: Text(
                                      listEvent.data[index].desc,
                                      maxLines: 3,
                                      style: TextStyle(fontSize: 18, color: Color(0xff056674)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ButtonBar(children: <Widget>[
                            FlatButton(
                              color: Color(0xff056674),
                              child: Text('Join'),
                              onPressed: () {

                                /// Get the data and manage it
                                newActPeople =
                                new List<String>.from(listEvent.data[index].actPeople);

                                /// Add the user from the list of registered
                                newActPeople
                                    .add(Provider.of<User>(context).uid);

                                /// Map it for the request
                                registeredPeople["act_people"] =
                                    newActPeople;

                                /// Call request to update the new list of user
                                _putJoinEvent(listEvent.data[index].id,
                                    registeredPeople);



                              },
                            ),
                          ]),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          }),
    );
  }
}
