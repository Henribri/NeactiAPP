import 'package:flutter/material.dart';
import 'composer.dart';

class Donate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height:30,),
          Center(
            child: Text('Vous pouvez nous soutenir',
            textAlign: TextAlign.center,

            style: TextStyle(

              fontSize: 30,
              letterSpacing: 3
            ),),
          ),
          SizedBox(height: 70,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Container(
                width: 150,
                height: 150,
                color: Colors.redAccent[400],
                child: FlatButton(
                  onPressed: (){},
                  child: Center(
                    child: Text(
                      'Publicité',
                      style: TextStyle(
                          fontFamily: 'Cali',
                          letterSpacing: 2,
                          color: Colors.white,
                          fontSize: 24
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 150,
                color: Colors.redAccent[400],
                child: FlatButton(
                  onPressed: (){},
                  child: Center(
                    child: Text(
                      'Don',
                      style: TextStyle(
                          fontFamily: 'Cali',
                          letterSpacing: 2,
                          color: Colors.white,
                          fontSize: 24
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 70,),
          Center(
            child: Text('Merci !',
              textAlign: TextAlign.center,

              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  letterSpacing: 3
              ),),
          ),
        ],
      ),

    );
  }
}
