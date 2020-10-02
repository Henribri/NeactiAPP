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
import 'package:neacti/models/apiUrl.dart';

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
  Category _category;


  final controllerP = PageController(initialPage: 0);

  //Get the categories
  Future<List<Category>> listCategory;

// Post method
  _postEvent({Map body}) async {
    String apiUrl = ApiUrl.apiUrl;
    String url = 'http://$apiUrl/events/';
    Map<String, String> headers = {"Content-type": "application/json"};
    Response response =
        await post(url, headers: headers, body: json.encode(body));
  }

  // Get category
  Future<List<Category>> _getCategoryList() async {
    String apiUrl = ApiUrl.apiUrl;
    Response response = await get('http://$apiUrl/category.json');
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
        _location = EventAddress(name, lat, lng, placeId);
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
                          backgroundColor: Color(0xffe8505b),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xff14b1ab)),
                          strokeWidth: 5)));
            } else {
              return Form(
                key: _formKey,
                child: PageView(

                  controller: controllerP,
                  scrollDirection: Axis.vertical,
                  children: [
                    // ######### PAGE Titre
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Nommons votre activité :',
                              style: TextStyle(
                                  color: Color(0xff056674), fontSize: 26, fontFamily: 'Rob'),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 340,
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            style: TextStyle(fontSize: 20),


                              cursorColor: Colors.red,
                              decoration: InputDecoration(

                                  labelStyle: TextStyle(color: Color(0xff056674), ),
                                  labelText: 'Titre',
                                  filled: true,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.red)),),
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
                        SwipeFooterPage(),
                      ],
                    ),



                    // ##### PAGE Description
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "En quoi consiste l'activité : ",
                              style: TextStyle(
                                  color: Color(0xff056674), fontSize: 26, fontFamily: 'Rob'),
                            )),
                        Container(
                          width: 340,
                          height: 100,
                          child: TextFormField(
                              style: TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              maxLines: 3,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.description,
                                    color: Colors.black,
                                  ),
                                  labelText: 'Description',
                                  labelStyle: TextStyle(
                                      color: Color(0xff056674)),
                                filled: true,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.red)),),
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
                        SwipeFooterPage(),
                      ],
                    ),


                    // ######### PAGE Nombre
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Combien de personne au total :',
                              style: TextStyle(
                                  color: Color(0xff056674), fontSize: 26, fontFamily: 'Rob'),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 200,
                          child: TextFormField(
                              style: TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              maxLines: 1,
                              initialValue: _nbr,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.group_add,
                                    color: Colors.black,
                                  ),
                                labelText: 'Participants',
                                labelStyle: TextStyle(
                                    color: Color(0xff056674)),
                                filled: true,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.red)),),
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
                        SwipeFooterPage(),
                      ],
                    ),

                    // ### PAGE Rdv
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Le point de rendez-vous :',
                              style: TextStyle(
                                  color: Color(0xff056674), fontSize: 26, fontFamily: 'Rob'),
                            )),
                        Container(
                          width: 260,



                          child: FlatButton.icon(
                            padding: EdgeInsets.all(10),
                            icon: Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 28,
                            ),
                            onPressed: () async {
                              // show input autocomplete with selected mode
                              // then get the Prediction selected
                              Prediction prediction =
                              await PlacesAutocomplete.show(
                                  context: context,
                                  apiKey:
                                  "AIzaSyBTVL32MeXqzbxxBRJjMjcpw13yz42Bzm0",
                                  mode: Mode.fullscreen,
                                  // Mode.overlay
                                  language: "fr",
                                  components: [
                                    new Component(Component.country, "fr")
                                  ]);
                              displayPrediction(prediction);
                            },
                            label: Flexible(
                              child: Text((() {
                                if (_location == null) {
                                  return "Select an address";
                                }

                                return _location.name;
                              })(), style: TextStyle(fontSize: 20, color: Colors.white)),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                side: BorderSide(color: Color(0xff056674))),
                            color: Color(0xff056674),
                          ),

                        ),
                        SwipeFooterPage()
                      ],
                    ),

                    // ##### PAGE Date Heure
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Le jour :',
                              style: TextStyle(
                                  color: Color(0xff056674), fontSize: 26, fontFamily: 'Rob'),
                            )),
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
                          icon: Icon(Icons.date_range, color:Colors.white),
                          label: Text((() {
                            if (_date == null) {
                              return "Not define";
                            }

                            return _date;
                          })(), style: TextStyle(fontSize: 20, color: Colors.white)),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              side: BorderSide(color: Color(0xff056674))),
                          color: Color(0xff056674),
                        ),
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Et l'heure:",
                              style: TextStyle(
                                  color: Color(0xff056674), fontSize: 26, fontFamily: 'Rob'),
                            )),
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
                          icon: Icon(Icons.access_time, color: Colors.white,),
                          label: Text(
                            (() {
                              if (_time == null) {
                                return "Not define";
                              }

                              return _time;
                            })(),
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              side: BorderSide(color: Color(0xff056674))),
                          color: Color(0xff056674),
                        ),
                        SwipeFooterPage()
                      ],
                    ),

                    //##### PAGE Categorie
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Choisir une catégorie :',
                              style: TextStyle(
                                  color: Color(0xff056674), fontSize: 26, fontFamily: 'Rob'),
                            )),
                        SizedBox(
                          height: 20,
                        ),
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
                                style: TextStyle(color: Color(0xff056674))),

                            value: _category,

                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                            items: listCategory.data
                                .map<DropdownMenuItem<Category>>(
                                    (Category value) {
                                  return DropdownMenuItem<Category>(
                                    value: value,
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
                        SwipeFooterPage()
                      ],
                    ),






                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Voici le rendu : ",
                              style: TextStyle(
                                  color: Color(0xff056674), fontSize: 26, fontFamily: 'Rob'),
                            )),
                        Card(
                          child: ExpansionTile(
                            initiallyExpanded: false,
                            leading: _category==null ? Icon(
                              Icons.close, size: 40,
                              color: Color(0xffff4b5c),
                            ):Icon(
                              IconData(_category.iconId,
                                  fontFamily: _category.fontFamily,
                                  fontPackage: _category.fontPackage),
                              size: 40,
                              color: Color(0xffff4b5c),
                            ),
                            title: _title == null
                                ? Text(
                                    'Titre',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff056674),
                                    ),
                                  )
                                : Text(
                                    _title,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff056674),
                                    ),
                                  ),
                            subtitle: _category == null
                                ? Text(
                                    'Error',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff056674),
                                    ),
                                  )
                                : Text(
                                    _category.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff056674),
                                    ),
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
                                    _date == null
                                        ? Text(
                                            'Error',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff056674),
                                            ),
                                          )
                                        : Text(
                                            DateFormat("dd-MM-yyyy")
                                                .format(DateTime.parse(_date)),
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff056674),
                                            ),
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
                                    _time == null
                                        ? Text(
                                            'Error',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff056674),
                                            ),
                                          )
                                        : Text(
                                            _time,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff056674),
                                            ),
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
                                      '0' + '/' + _nbr.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff056674),
                                      ),
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

                                        // Launch google map url

                                        child: _location == null
                                            ? Text(
                                                'Error',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff056674),
                                                ),
                                              )
                                            : Text(
                                                _location.name,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff056674),
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
                                        child: _desc == null
                                            ? Text(
                                                'Error',
                                                maxLines: 3,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff056674),
                                                ),
                                              )
                                            : Text(
                                                _desc,
                                                maxLines: 3,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff056674),
                                                ),
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
                                  onPressed: () {},
                                ),
                              ]),
                            ],
                          ),
                        ),

                        SizedBox(height: 30,),
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Il ne vous reste plus qu'à le publier : ",
                              style: TextStyle(
                                  color: Color(0xff056674), fontSize: 26, fontFamily: 'Rob'),
                            )),
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

                                  _date + ' ' + _time.replaceAll(' ', ''),
                                  _location,
                                  [Provider.of<User>(context).uid],
                                  int.parse(_nbr),
                                  _desc,
                                  null,
                                  _category.id);

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
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                duration: Duration(seconds: 1),
                              ));
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              side: BorderSide(color: Color(0xffff4b5c))),
                          color: Color(0xffff4b5c),
                          child: Text("Publier l'activité",style: TextStyle(fontSize: 20, color: Colors.white),),
                        ),
                      ],
                    ),




                  ],
                ),
              );
           }
          }),
    );
  }
}

class SwipeFooterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
        ),
        Text('Swiper pour continuer le formulaire'),
        Icon(
          Icons.arrow_downward,
          color: Color(0xff056674),
          size: 64,
        )
      ],
    );
  }
}
