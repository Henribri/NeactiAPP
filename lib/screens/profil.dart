import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neacti/models/apiUrl.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          /*Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Les News',
                style: TextStyle(
                    color: Color(0xff056674),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,fontFamily: 'Rob'),
              ),
            ),
          ),*/
          Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              margin: EdgeInsets.fromLTRB(10,10,10,40 ),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Carousel(
              borderRadius: true,
                images: [
                  NetworkImage(
                      'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                  NetworkImage(
                      'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),

                ],
                showIndicator: true,
                autoplay: true,
                autoplayDuration: Duration(seconds: 5),
                indicatorBgPadding: 1,
              ),
            ),
          ),
          Divider(
            color: Color(0xffff4b5c),
            thickness: 2,
            endIndent: 100,
            indent: 100,
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Autres onglets :',
                style: TextStyle(
                    color: Color(0xff056674),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,fontFamily: 'Rob'),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            child: Text('Go to settings'),
            color: Colors.red,
            onPressed: (){
              Navigator.pushNamed(context, '/profil/settings');
            },


          )

        ],
      ),
    ));
  }
}
