import 'package:flutter/material.dart';
import 'package:neacti/screens/loading.dart';
import 'package:neacti/services/auth.dart';

import '../composer.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool loading = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
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
                    child: Text("Sign in page", style: TextStyle(color: Colors.pinkAccent[400], fontSize: 20, fontWeight: FontWeight.bold),),
                  ),

                  SizedBox(height: 50,),

                  Container(
                    width: 300,
                    child: TextFormField(
                      cursorColor: Colors.pinkAccent[400],
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
                    child: Text("Login", style: TextStyle(color:Colors.white)),
                    onPressed: ()async{
                      if (_formKey.currentState.validate()) {

                        setState(() =>loading=true);
                        dynamic result=await _auth.signInWithEmail(email, password);

                        if (result == null){
                          setState(() {
                            error="Pas bon frero";
                            setState(() =>loading=false);
                          });
                        }
                      }

                    },
                  ),
                  SizedBox(height: 20),
                  Text(error, style: TextStyle(color: Colors.pinkAccent[400], fontSize: 14),),
                  SizedBox(height: 40,),


                  FlatButton(
                    child: Text("No account ?", style: TextStyle(color:Colors.pink, fontSize: 15 )),
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
