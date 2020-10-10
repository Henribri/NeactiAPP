import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeaFlushBar {

  /// Define parameters
   String flushTitle;
   String flushMessage;
   bool isError;
   BuildContext context;
   bool isDismissible;


  /// Constructor
  NeaFlushBar({this.flushTitle, this.flushMessage, this.isError, this.context, this.isDismissible});


  /// Return the Flushbar
  Flushbar getNeaFlushbar(){
    return Flushbar(

      title:  flushTitle,
      message:  flushMessage,
      backgroundColor: Theme.of(context).primaryColorDark,
      duration:  Duration(seconds: 2, milliseconds: 40),
      animationDuration: Duration(seconds: 1,),
      margin: EdgeInsets.fromLTRB(5,0,5,70),
      isDismissible: isDismissible,
      borderRadius: 5,
      icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: isError==false ? Colors.greenAccent :Color(0xffff4b5c),
      ),
    );

  }

}
