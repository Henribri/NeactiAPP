import 'package:flutter/material.dart';
import 'package:neacti/screens/loading.dart';
import 'package:neacti/services/auth.dart';


class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  /// Get the auth service
  final AuthService _auth = AuthService();

  /// Get an id for for the form
  final _formKey = GlobalKey<FormState>();

  /// Var to state of the loading
  bool loading = false;

  /// Values of the form
  String email = '';
  String password = '';
  String confirmPassword ='';
  String error = '';

  @override
  Widget build(BuildContext context) {

    /// Display loading page or not
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
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
                      color: Theme.of(context).primaryColor,
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
                        "S'inscrire",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
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
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 16),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor, width: 2),
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
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 16),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor, width: 2),
                          ),
                          labelText: "Mot de passe",
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

                    Container(
                      width: 300,
                      child: TextFormField(
                        obscureText: true,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          labelStyle:
                          TextStyle(color: Colors.black, fontSize: 16),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor, width: 2),
                          ),
                          labelText: "Confirmez votre mot de passe",
                        ),
                        onChanged: (val) {
                          setState(() => confirmPassword = val);
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
                      color: Theme.of(context).primaryColor,
                      child: Text("S'inscrire",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState.validate() && password==confirmPassword) {

                          /// Register the user with the auth service
                          dynamic result =
                              await _auth.registerWithEmail(email, password);
                          setState(() {
                            /// Set loading page during the request
                            loading = true;
                          });

                          if (result == null) {
                            setState(() {

                              /// Display error message
                              error = "Erreur";
                              setState(() {

                                /// Cancel the loading page
                                loading = false;
                              });
                            });
                          }
                        }
                        else{
                          setState(() {

                            /// Display error message
                            error = "Erreur de mot de passe";

                            /// Cancel the loading page
                            setState(() => loading = false);
                          });
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      error,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 14),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    /// Change the page to display
                    FlatButton(
                      child: Text("Vous avez déjà un compte ?",
                          style: TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 15)),
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
