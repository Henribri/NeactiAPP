import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'composer.dart';
import 'package:http/http.dart';
import 'dart:convert';



class Invite extends StatefulWidget {
  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {

  final _formKey = GlobalKey<FormState>();
  String _nbr='0';
  String _date = "Non définie";
  String _time = "Non définie";
  String _catvalue= 'Sport';
  String _desc = 'Hello';






  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[

            SizedBox(height: 10,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[


                DropdownButton<String>(


                  underline: Container(
                      height: 2,

                      color:Colors.red
                  ),
                  value: _catvalue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  onChanged: (value){
                    setState(() {
                      _catvalue=value;
                    });
                  },
                  items: <String>['Sport', 'Jeu', 'Action', 'Jeu-vidéo']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                      .toList(),
                ),

                Container(
                  width: 100,



                  child: TextFormField(
                      cursorColor: Colors.red,
                      maxLines: 1,
                      initialValue: '5',
                      decoration: InputDecoration(

                          prefixIcon: Icon(Icons.group_add, color: Colors.black,),

                          labelStyle: TextStyle(color: Colors.black, fontSize: 14),

                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)
                          )
                      ),
                      validator: (value){
                        if(value.isEmpty || value=='0'){
                          return "Please enter some text";
                        }
                        _nbr=value;
                        return null;
                      }
                  ),
                ),


              ],),

            SizedBox(height: 10,),




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
                        borderSide: BorderSide(color: Colors.red)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)
                    )
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter some text";
                    }
                    return null;
                  }
                ),
              ),

              ],),
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
                              borderSide: BorderSide(color: Colors.red)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)
                          )
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return "Please enter some text";
                        }
                        return null;
                      }
                  ),
                ),

              ],),
            Container(
              width: 340,
              margin: EdgeInsets.all(10),
              child: TextFormField(
                  cursorColor: Colors.red,

                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Lieu',
                      prefixIcon: Icon(Icons.location_on, color: Colors.black,),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)
                      )
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter some text";
                    }
                    return null;
                  }
              ),
            ),
            
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                FlatButton.icon(
                  onPressed: (){showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(3000)).then((date){
                    setState(() {
                      _date= DateFormat("dd-MM-yyyy").format(date).toString();
                    });
                  });},
                  icon: Icon(Icons.date_range),
                  label: Text(_date, style: TextStyle(fontSize: 16)),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.red)
                  ),
                ),

                FlatButton.icon(
                onPressed: (){showTimePicker(context: context, initialTime: TimeOfDay.now()).then((time){

                  setState(() {
                    _time='${time.hour} : ${time.minute}';

                  });
                });
                    },
                  icon: Icon(Icons.access_time),
                  label: Text(_time, style: TextStyle(fontSize: 16),),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.red)
                  ),
                ),

              ],
            ),

            SizedBox(height: 10,),

            Container(
              width: 340,
              height: 100,


              child: TextFormField(

                  cursorColor: Colors.red,
                  maxLines: 3,

                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.description, color: Colors.black,),
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 14),

                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)
                      )
                  ),
                  validator: (value){
                    if(value.isEmpty || value=='0'){
                      return "Please enter some text";
                    }
                    _nbr=value;
                    return null;
                  }
              ),
            ),


      RaisedButton(
      onPressed: () {
      // Validate returns true if the form is valid, otherwise false.
      if (_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.

      Scaffold
          .of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
      }
      },
      child: Text('Submit'),
      ),


          ],
        ),
      ),
    );
  }
}
