import 'package:flutter/material.dart';
import 'package:neacti/services/auth.dart';

import '../composer.dart';





class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();


  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(


                children: <Widget>[
                  SizedBox(height: 50,),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                    color: Colors.pinkAccent[400],
                    child: Text("Neacti", style: TextStyle(color: Colors.white,fontFamily: 'Fred', fontSize: 50 )),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    child: Text("Sign up page", style: TextStyle(color: Colors.pinkAccent[400], fontSize: 20, fontWeight: FontWeight.bold),),
                  ),

                  SizedBox(height: 50,),

                  Container(
                    width: 300,
                    child: TextFormField(
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                        fillColor: Colors.white,
                        filled: true,

                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent[400], width: 2),
                        ),
                        labelText: "Email",
                      ),
                      onChanged: (val){
                        setState(() =>email=val);

                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },

                    ),
                  ),

                  SizedBox(height: 20,),

                  Container(
                    width: 300,
                    child: TextFormField(
                      obscureText: true,
                      cursorColor: Colors.pinkAccent[400],
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                        fillColor: Colors.white,
                        filled: true,

                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pinkAccent[400], width: 2),
                        ),
                        labelText: "Password",
                      ),
                      onChanged: (val){
                        setState(() =>password=val);

                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(height: 20,),
                  RaisedButton(
                    color: Colors.pink,
                    child: Text("Register", style: TextStyle(color:Colors.white)),
                    onPressed: ()async{
                      if (_formKey.currentState.validate()) {

                        dynamic result=await _auth.registerWithEmail(email, password);
                        if (result == null){
                          setState(() {
                            error="Pas bon frero";
                          });
                        }
                      }

                    },
                  ),
                  SizedBox(height: 20),
                  Text(error, style: TextStyle(color: Colors.pinkAccent[400], fontSize: 14),),
                  SizedBox(height: 40,),


                  FlatButton(
                    child: Text("Already an account ?", style: TextStyle(color:Colors.pink, fontSize: 15 )),
                    onPressed: ()  {
                      widget.toggleView();
                    },
                  ),



                ],
              ),
            ),


          )
      ),
    );
  }
}
