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

class Invite extends StatefulWidget {
  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {

  // Define variables of the form
  final _formKey = GlobalKey<FormState>();
  String _nbr = '2';
  String _date = "Non définie";
  String _time = "Non définie";
  String _desc;
  String _title;
  String _message;
  String _location;
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
                      Container(
                        width: 340,
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
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
                            }),
                      ),
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
                            label: Text(_date, style: TextStyle(fontSize: 16)),
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
                              _time,
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
                          if (_formKey.currentState.validate()) {
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
                              Scaffold.of(context)
                                  .showSnackBar(SnackBar(
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
