import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:neacti/buisness_logic/blocs/bloc_activities/activities_bloc.dart';
import 'package:neacti/buisness_logic/blocs/bloc_activities/activities_event.dart';
import 'package:neacti/buisness_logic/blocs/bloc_activities/activities_state.dart';
import 'package:neacti/views/utils/flushbar.dart';
import 'package:neacti/buisness_logic/models/apiUrl.dart';
import 'package:neacti/buisness_logic/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:neacti/buisness_logic/models/event.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';

class ActivitiesPage extends StatefulWidget {

  bool joinPage;
  final Key key;
  ActivitiesPage({ @required this.joinPage, @required this.key});


  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {

  Future<void> _getRefresh() async {
    setState(() {});
  }


  /// Variable to contain the list of User registered for the event
  Map<String, List<String>> registeredPeople = new Map<String, List<String>>();

  /// List to contain actPeople from gotten data
  List<String> newActPeople;


  /// Build join page
  @override
  Widget build(BuildContext context) {
    return Center(
      /// Get the data to display
      child: BlocProvider(
        create: (BuildContext context) =>
            ActivitiesBloc()..add(ActivityEventGet(uid: context.read<User>().uid, joinPage:widget.joinPage)),
        child: BlocListener<ActivitiesBloc, ActivitiesState>(
          listener: (context, state) {

            if (state is ActivitiesPatchFailure) {
              NeaFlushBar(
                      flushTitle: "Erreur",
                      flushMessage: "Veuillez réessayer",
                      isError: true,
                      context: context,
                      isDismissible: true)
                  .getNeaFlushbar()
                  .show(context);
              context.bloc<ActivitiesBloc>().add(ActivityEventGet(uid: context.read<User>().uid, joinPage: widget.joinPage));
            } else if (state is ActivitiesPatchSuccess) {
              /// Alert the creation of an event
              NeaFlushBar(
                      flushTitle: widget.joinPage == false ? "Votre plan \à \ét\é retir\é" : "Vous avez rejoint une activit\é",
                      flushMessage: widget.joinPage == false ? "Il est toujours disponible dans Rejoindre" : "Elle est disponible dans Mes plans",
                      isError: false,
                      context: context,
                      isDismissible: true)
                  .getNeaFlushbar()
                  .show(context);
              context.bloc<ActivitiesBloc>().add(ActivityEventGet(uid: context.read<User>().uid, joinPage: widget.joinPage));
            }

          },
          child: BlocBuilder<ActivitiesBloc, ActivitiesState>(builder: (context, state) {

            /// If no data and no connection then return error
            if (state is ActivitiesConnectionFailure) {
              return RefreshIndicator(
                backgroundColor: Theme.of(context).primaryColor,
                color: Colors.white,
                onRefresh: _getRefresh,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    Center(
                      child: Text(
                        "Erreur de connection",
                        style: TextStyle(
                            fontFamily: 'Fred',
                            fontSize: 26,
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                  ],
                ),
              );
            }

            /// If no data but connected return circle to wait
            else if (state.getActivities == null) {
              return Center(
                  child: Container(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColorDark),
                          strokeWidth: 5)));
            }

            /// If there is no event display a message
            else if (state.getActivities.length == 0) {
              return RefreshIndicator(
                backgroundColor: Theme.of(context).primaryColor,
                color: Colors.white,
                onRefresh: _getRefresh,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    Center(
                      child: Text(
                        "Pas d'event pour le moment.",
                        style: TextStyle(
                            fontFamily: 'Fred',
                            fontSize: 26,
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              /// If we get data then display it
              return RefreshIndicator(
                backgroundColor: Theme.of(context).primaryColor,
                color: Colors.white,
                onRefresh: _getRefresh,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  child: ListView.builder(
                    itemCount: state.getActivities.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Card(
                            color: Colors.white,
                            child: ExpansionTile(
                              leading: Icon(
                                IconData(
                                    state.getActivities[index].category.iconId,
                                    fontFamily: state.getActivities[index]
                                        .category.fontFamily,
                                    fontPackage: state.getActivities[index]
                                        .category.fontPackage),
                                size: 40,
                                color: Theme.of(context).primaryColor,
                              ),
                              title: Text(
                                state.getActivities[index].title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.getActivities[index].category.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.group,
                                        size: 30,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        state.getActivities[index].actPeople
                                                .length
                                                .toString() +
                                            '/' +
                                            state.getActivities[index].allPeople
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.date_range,
                                            size: 30,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            DateFormat("dd-MM-yyyy").format(
                                                DateTime.parse(state
                                                    .getActivities[index]
                                                    .dateTime
                                                    .substring(0, 10))),
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            size: 30,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            state.getActivities[index].dateTime
                                                .substring(11, 16),
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                          ),
                                        ],
                                      )
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
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: FlatButton(
                                          padding: EdgeInsets.all(0),
                                          onPressed: () async {
                                            /// Launch google map url
                                            String lat = state
                                                .getActivities[index]
                                                .address
                                                .lat
                                                .toString();
                                            String lon = state
                                                .getActivities[index]
                                                .address
                                                .lon
                                                .toString();
                                            String placeId = state
                                                .getActivities[index]
                                                .address
                                                .placeId
                                                .toString();
                                            String url =
                                                'https://www.google.com/maps/search/?api=1&query=$lat,$lon&query_place_id=$placeId';
                                            if (await canLaunch(url)) {
                                              launch(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          },
                                          child: Text(
                                            state.getActivities[index].address
                                                .name,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
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
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Container(
                                          child: Text(
                                            state.getActivities[index].desc,
                                            maxLines: 3,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Theme.of(context)
                                                    .primaryColorDark),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ButtonBar(children: <Widget>[
                                  FlatButton(
                                    color: Theme.of(context).primaryColorDark,
                                    child: widget.joinPage == true ? Text('Rejoindre') : Text('Quitter'),
                                    onPressed: () {

                                        /// Call request ti update the new list of user
                                        context.bloc<ActivitiesBloc>().add(
                                            ActivityEventPatch(uid: context.read<User>().uid,
                                                eventId: state.getActivities[index]
                                                    .id,
                                                newActPeople: new List<String>.from(
                                                    state.getActivities[index]
                                                        .actPeople),joinPage: widget.joinPage));


                                    },
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    },
                  ),
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
