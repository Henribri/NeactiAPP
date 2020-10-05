import 'package:flutter/material.dart';
import 'package:neacti/screens/loading.dart';
import 'package:neacti/services/auth.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  /// Get the auth service
  final AuthService _auth = AuthService();

  /// Get an id for for the form
  final _formKey = GlobalKey<FormState>();

  /// Var to state of the loading
  bool loading = false;

  /// Values of the form
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {

    /// Display loading page or not
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(

                /// Use form to send data and validator to check it
                child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                      color: Colors.pinkAccent[400],
                      child: Text("Neacti",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Fred',
                              fontSize: 50)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        "Sign in page",
                        style: TextStyle(
                            color: Colors.pinkAccent[400],
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(
                      height: 50,
                    ),

                    Container(
                      width: 300,
                      child: TextFormField(
                        cursorColor: Colors.pinkAccent[400],
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 16),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pinkAccent[400], width: 2),
                          ),
                          labelText: "Email",
                        ),
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      width: 300,
                      child: TextFormField(
                        obscureText: true,
                        cursorColor: Colors.pinkAccent[400],
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 16),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pinkAccent[400], width: 2),
                          ),
                          labelText: "Password",
                        ),
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.pink,
                      child:
                          Text("Login", style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {

                          /// SignIn the user with the auth service
                          dynamic result =
                              await _auth.signInWithEmail(email, password);

                          /// Set loading page during the request
                          setState(() => loading = true);

                          if (result == null) {
                            setState(() {

                              /// Display error message
                              error = "Error";

                              /// Cancel the loading page
                              setState(() => loading = false);
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      error,
                      style: TextStyle(
                          color: Colors.pinkAccent[400], fontSize: 14),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    /// Change the page to display
                    FlatButton(
                      child: Text("No account ?",
                          style: TextStyle(color: Colors.pink, fontSize: 15)),
                      onPressed: () {
                        widget.toggleView();
                      },
                    ),
                  ],
                ),
              ),
            )),
          );
  }
}
