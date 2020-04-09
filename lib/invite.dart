import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'composer.dart';



class Invite extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
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
            Container(
              width: 340,
              margin: EdgeInsets.all(10),
              child: TextFormField(
                  cursorColor: Colors.red,

                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Lieu',
                      prefixIcon: Icon(Icons.location_on, color: Colors.red,),
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
              Container(
                width: 130,
                margin: EdgeInsets.all(10),
                child: TextFormField(

                    cursorColor: Colors.red,

                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group_add),

                        labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                        labelText: 'Nombre',
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
                Container(
                  width: 130,
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                      cursorColor: Colors.red,

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.date_range),
                          labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                          labelText: 'Date',
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
              ]
              ,
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
