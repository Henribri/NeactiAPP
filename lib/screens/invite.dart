import 'dart:ffi';
import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:neacti/components/flushbar.dart';
import 'package:neacti/models/category.dart';
import 'package:neacti/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neacti/models/event.dart';
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

  /// Define variables of the form
  final _formKey = GlobalKey<FormState>();
  String _nbr = '2';
  String _date;
  String _time;
  String _desc;
  String _title;
  EventAddress _location;
  Category _category;

  /// Controller for PageView
  final _controllerP = PageController(initialPage: 0);

  ///Get the categories
  Future<List<Category>> listCategory;

  /// Post method
  Future<Widget> _postEvent({Map body}) async {
    String apiUrl = ApiUrl.apiUrl;
    String url = 'http://$apiUrl/events/';
    Map<String, String> headers = {"Content-type": "application/json"};
    Response response =
        await post(url, headers: headers, body: json.encode(body));

    if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
      /// Alert error
      NeaFlushBar(flushTitle:"Erreur lors de l'envoi", flushMessage:"~~~~~~~", isError: true, context: context, isDismissible: true).getNeaFlushbar().show(context);
    }else{
      /// Alert the creation of an event
      NeaFlushBar(flushTitle:"Votre activit\é a bien \ét\é cr\é\ée", flushMessage:"Elle est disponible dans vos plans", isError: false, context: context, isDismissible: true).getNeaFlushbar().show(context);

      setState(() {

        /// Return to the page one if successful
        _controllerP.jumpTo(0);
      });
      //flush.dismiss(true);
    }
  }

  /// Get category
  Future<List<Category>> _getCategoryList() async {
    String apiUrl = ApiUrl.apiUrl;
    Response response = await get('http://$apiUrl/category.json');
    List<dynamic> data = jsonDecode(response.body);

    return data.map((i) => Category.fromJson(i)).toList();
  }

  /// Get the prediction of google place search and update the value of the location
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

  /// Boolean to test connection
  bool isConnected = true;

  /// Test the connection and update the bool
  _getConnection() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult==ConnectivityResult.none){
      isConnected=false;
    }
    else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      isConnected=true;
    }
  }

  /// Refresh page
  Future<void> _getRefresh() async {
    setState(() {

    });
  }

  /// initState to use Future Builder only one time
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

            /// Test the connection
            _getConnection();

            /// If no data but connected return circle to wait
            if (listCategory.data == null&& isConnected) {

              /// If no data return a circle wait
              return Center(
                  child: Container(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                          backgroundColor: Color(0xffff4b5c),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColorDark),
                          strokeWidth: 5)));
            }

            /// If no data and no connection then return error
            else if(listCategory.data == null && isConnected==false){
              return RefreshIndicator(
                backgroundColor: Theme.of(context).primaryColor,
                color: Colors.white,
                onRefresh: _getRefresh,
                child: ListView(
                  children: [
                    SizedBox(height: 200,),
                    Center(
                      child: Text(
                        "Erreur de connection",
                        style: TextStyle(fontFamily: 'Fred', fontSize: 26, color: Theme.of(context).primaryColorLight)),
                      ),



                  ],

                ),
              );
            }

            else {
              return Form(
                key: _formKey,
                child: PageView(

                  controller: _controllerP,
                  scrollDirection: Axis.vertical,
                  children: [

                    /// Title page
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Nommons votre activité :',
                              style: Theme.of(context).textTheme.headline2
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 340,
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorLight),


                              cursorColor: Colors.red,
                              decoration: InputDecoration(

                                  labelStyle: TextStyle(color: Theme.of(context).primaryColorLight, ),
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



                    /// Description page
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "En quoi consiste l'activité : ",
                                style: Theme.of(context).textTheme.headline2
                            )),
                        Container(
                          width: 340,
                          height: 100,
                          child: TextFormField(
                              style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorLight),
                              cursorColor: Colors.red,
                              maxLines: 3,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.description,
                                    color: Theme.of(context).primaryColor
                                  ),
                                  labelText: 'Description',
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColorLight, ),
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


                    /// Participant page
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Combien de personne au total :',
                                style: Theme.of(context).textTheme.headline2
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 200,
                          child: TextFormField(
                              style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColorLight),
                              cursorColor: Colors.red,
                              maxLines: 1,
                              initialValue: _nbr,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.group_add,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                labelText: 'Participants',
                                labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColorLight,),
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

                    /// Place page
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Le point de rendez-vous :',
                                style: Theme.of(context).textTheme.headline2
                            )),
                        Container(
                          width: 260,



                          child: FlatButton.icon(
                            padding: EdgeInsets.all(10),
                            icon: Icon(
                              Icons.location_on,
                              color: Theme.of(context).primaryColor,
                              size: 28,
                            ),
                            onPressed: () async {
                              /// show input autocomplete with selected mode
                              /// then get the Prediction selected
                              Prediction prediction =
                              await PlacesAutocomplete.show(
                                  context: context,
                                  apiKey:
                                  "AIzaSyBTVL32MeXqzbxxBRJjMjcpw13yz42Bzm0",
                                  mode: Mode.fullscreen,
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
                              })(), style: Theme.of(context).textTheme.headline4),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                side: BorderSide(color: Theme.of(context).buttonColor),),
                            color: Theme.of(context).buttonColor,
                          ),

                        ),
                        SwipeFooterPage()
                      ],
                    ),

                    /// Date and time page
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Le jour :',
                                style: Theme.of(context).textTheme.headline2
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
                          icon: Icon(Icons.date_range, color: Theme.of(context).primaryColor),
                          label: Text((() {
                            if (_date == null) {
                              return "Not define";
                            }

                            return _date;
                          })(),  style: Theme.of(context).textTheme.headline4),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                            side: BorderSide(color: Theme.of(context).buttonColor),),
                          color: Theme.of(context).buttonColor,
                        ),
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Et l'heure:",
                                style: Theme.of(context).textTheme.headline2
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
                          icon: Icon(Icons.access_time, color: Theme.of(context).primaryColor,),
                          label: Text(
                            (() {
                              if (_time == null) {
                                return "Not define";
                              }

                              return _time;
                            })(),
                              style: Theme.of(context).textTheme.headline4
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                            side: BorderSide(color: Theme.of(context).buttonColor),),
                          color: Theme.of(context).buttonColor,
                        ),
                        SwipeFooterPage()
                      ],
                    ),

                    /// Category page
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Choisir une catégorie :',
                                style: Theme.of(context).textTheme.headline2
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

                            hint: Text('Categories',
                                style: TextStyle(color: Theme.of(context).primaryColorLight,)),

                            value: _category,

                            dropdownColor: Theme.of(context).buttonColor,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                            items: listCategory.data
                                .map<DropdownMenuItem<Category>>(
                                    (Category value) {
                                  return DropdownMenuItem<Category>(
                                    value: value,
                                    child: Text(value.name, style: TextStyle(color: Theme.of(context).primaryColorLight),),
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






                    /// Send page
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Voici le rendu : ",
                                style: Theme.of(context).textTheme.headline2
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
                                        color: Theme.of(context).primaryColorDark,
                                    ),
                                  )
                                : Text(
                                    _title,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  ),
                            subtitle: _category == null
                                ? Text(
                                    'Error',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  )
                                : Text(
                                    _category.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColorDark,
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
                                              color: Theme.of(context).primaryColorDark,
                                            ),
                                          )
                                        : Text(
                                            DateFormat("dd-MM-yyyy")
                                                .format(DateTime.parse(_date)),
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context).primaryColorDark,
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
                                              color: Theme.of(context).primaryColorDark,
                                            ),
                                          )
                                        : Text(
                                            _time,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context).primaryColorDark,
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
                                        color: Theme.of(context).primaryColorDark,
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

                                        /// Launch google map url
                                        child: _location == null
                                            ? Text(
                                                'Error',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Theme.of(context).primaryColorDark,
                                                ),
                                              )
                                            : Text(
                                                _location.name,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Theme.of(context).primaryColorDark,
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
                                                  color: Theme.of(context).primaryColorDark,
                                                ),
                                              )
                                            : Text(
                                                _desc,
                                                maxLines: 3,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Theme.of(context).primaryColorDark,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ButtonBar(children: <Widget>[
                                FlatButton(
                                  color: Theme.of(context).primaryColorDark,
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
                              "Il ne vous reste plus qu'à la publier : ",
                                style: Theme.of(context).textTheme.headline2
                            )),
                        RaisedButton(

                          onPressed: () {

                            /// Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState.validate() &&
                                _location != null &&
                                _date != null &&
                                _time != null) {

                              /// Create event object to post
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


                              //Flushbar flush = NeaFlushBar(flushTitle:"Veuillez patienter", flushMessage:"Nous ajoutons votre activité", isError: false, context: context, isDismissible: false).getNeaFlushbar();

                              //flush.show(context);
                              /// Call the post method with a map of the object
                              _postEvent(body: newEvent.toMap());


                            } else{
                              NeaFlushBar(flushTitle:"Erreur", flushMessage:"~~~~~~~", isError: true, context: context, isDismissible: true).getNeaFlushbar().show(context);
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
        Text('Swiper pour continuer le formulaire', style: TextStyle(color: Theme.of(context).primaryColorLight,),),
        Icon(
          Icons.arrow_downward,
          color: Theme.of(context).primaryColorLight,
          size: 64,
        )
      ],
    );
  }
}
