import 'dart:ffi';
import 'package:neacti/models/category.dart';
import 'package:neacti/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neacti/models/event.dart';
import 'composer.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:neacti/models/address.dart';
class Invite extends StatefulWidget {
  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  // Define variables of the form
  final _formKey = GlobalKey<FormState>();
  String _nbr = '2';
  String _date;
  String _time;
  String _desc;
  String _title;
  String _message;
  EventAddress _location;
  String _category;

  //Get the categories
  Future<List<Category>> listCategory;

// Post method
  _postEvent({Map body}) async {
    String url = 'http://10.0.2.2:8000/events/';
    Map<String, String> headers = {"Content-type": "application/json"};
    Response response =
        await post(url, headers: headers, body: json.encode(body));
    int statusCode = response.statusCode;
  }

  // Get category
  Future<List<Category>> _getCategoryList() async {
    Response response = await get('http://10.0.2.2:8000/category.json');
    List<dynamic> data = jsonDecode(response.body);

    return data.map((i) => Category.fromJson(i)).toList();
  }


  // Get the prediction of google place search and update the value of the location
  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail = await GoogleMapsPlaces(
              apiKey: "AIzaSyBTVL32MeXqzbxxBRJjMjcpw13yz42Bzm0")
          .getDetailsByPlaceId(p.placeId);

      String placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;
      String name = detail.result.formattedAddress;


      setState(() {
        _location=EventAddress(name, lat, lng, placeId);
      });
    }
  }

  // initState to use Future Builder only one time
  @override
  void initState() {
    super.initState();
    listCategory = _getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: listCategory,
          builder: (BuildContext context, AsyncSnapshot listCategory) {
            if (listCategory.data == null) {
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
              return SingleChildScrollView(
                // Use form to send data and validator to check it
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 200,
                            child: DropdownButtonFormField(
                              elevation: 0,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent, width: 2))),

                              //underline: Container(height: 2, color: Colors.red),
                              hint: Text('Categories',
                                  style: TextStyle(color: Colors.black)),

                              value: _category,

                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              items: listCategory.data
                                  .map<DropdownMenuItem<String>>(
                                      (Category value) {
                                return DropdownMenuItem<String>(
                                  value: value.id,
                                  child: Text(value.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _category = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Please select an item";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Container(
                            width: 100,
                            child: TextFormField(
                                cursorColor: Colors.red,
                                maxLines: 1,
                                initialValue: _nbr,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.group_add,
                                      color: Colors.black,
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red))),
                                onChanged: (value) {
                                  setState(() => _nbr = value);
                                },
                                validator: (value) {
                                  if (value.isEmpty || value == '0') {
                                    return "Please enter some text";
                                  }
                                  _nbr = value;
                                  return null;
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 340,
                            margin: EdgeInsets.all(10),
                            child: TextFormField(
                                cursorColor: Colors.red,
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.black),
                                    labelText: 'Titre',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red))),
                                onChanged: (value) {
                                  setState(() => _title = value);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter some text";
                                  }
                                  return null;
                                }),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 340,
                            margin: EdgeInsets.all(10),
                            child: TextFormField(
                                cursorColor: Colors.red,
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.black),
                                    labelText: 'Message',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red))),
                                onChanged: (value) {
                                  setState(() => _message = value);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter some text";
                                  }
                                  return null;
                                }),
                          ),
                        ],
                      ),
                      FlatButton.icon(
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          // show input autocomplete with selected mode
                          // then get the Prediction selected
                          Prediction prediction = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: "AIzaSyBTVL32MeXqzbxxBRJjMjcpw13yz42Bzm0",
                              mode: Mode.fullscreen,
                              // Mode.overlay
                              language: "fr",
                              components: [
                                new Component(Component.country, "fr")
                              ]);
                          displayPrediction(prediction);
                        },
                        label: Text((() {
                          if (_location == null) {
                            return "Select an address";
                          }

                          return _location.name;
                        })(), style: TextStyle(fontSize: 16)),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.red)),
                      ),
                      /*
                              cursorColor: Colors.red,
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.black),
                                  labelText: 'Lieu',
                                  prefixIcon: Icon(
                                    Icons.location_on,
                                    color: Colors.black,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red))),
                              onChanged: (value) {
                                setState(() => _location = value);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter some text";
                                }
                                return null;
                              }*/

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton.icon(
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(3000))
                                  .then((date) {
                                setState(() {
                                  _date = DateFormat("yyyy-MM-dd")
                                      .format(date)
                                      .toString();
                                });
                              });
                            },
                            icon: Icon(Icons.date_range),
                            label: Text((() {
                              if (_date == null) {
                                return "Not define";
                              }

                              return _date;
                            })(), style: TextStyle(fontSize: 16)),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.red)),
                          ),
                          FlatButton.icon(
                            onPressed: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((time) {
                                setState(() {
                                  _time = '${time.hour} : ${time.minute}';
                                });
                              });
                            },
                            icon: Icon(Icons.access_time),
                            label: Text(
                              (() {
                                if (_time == null) {
                                  return "Not define";
                                }

                                return _time;
                              })(),
                              style: TextStyle(fontSize: 16),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.red)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 340,
                        height: 100,
                        child: TextFormField(
                            cursorColor: Colors.red,
                            maxLines: 3,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.description,
                                  color: Colors.black,
                                ),
                                labelText: 'Description',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red))),
                            onChanged: (value) {
                              setState(() => _desc = value);
                            },
                            validator: (value) {
                              if (value.isEmpty || value == '0') {
                                return "Please enter some text";
                              }

                              return null;
                            }),
                      ),
                      RaisedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState.validate() &&
                              _location != null &&
                              _date != null &&
                              _time != null) {
                            // Create event object to post
                            Event newEvent = Event(
                                null,
                                _title,
                                _message,
                                _date + ' ' + _time.replaceAll(' ', ''),
                                _location,
                                [Provider.of<User>(context).uid],
                                int.parse(_nbr),
                                _desc,
                                null,
                                _category);

                            // Call the post method with a map of the object
                            _postEvent(body: newEvent.toMap());

                            setState(() {
                              // Alert the creation of an event
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.greenAccent,
                                content: Text(
                                  'Your event has been created.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                duration: Duration(seconds: 1),
                              ));
                            });
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.pinkAccent,
                              content: Text(
                                'Error you missed a field',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              duration: Duration(seconds: 1),
                            ));
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
