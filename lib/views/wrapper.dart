import 'package:flutter/material.dart';
import 'package:neacti/main.dart';
import 'package:neacti/buisness_logic/models/user.dart';
import 'package:neacti/views/authenticate/authenticate.dart';
import 'package:neacti/views/authenticate/sign_in.dart';
import 'package:neacti/views/mainpage.dart';
import 'package:provider/provider.dart';
import 'package:neacti/main.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Get the provider user
    final user = Provider.of<User>(context);

    // Return home or authenticate
    if(user==null){
      return Authenticate();

    }else{
      return MainPage();
    }
  }
}
