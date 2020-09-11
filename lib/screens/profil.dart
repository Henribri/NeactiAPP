import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'composer.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 40, top: 20),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Carousel(
                images: [
                  NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                  NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                ],
                showIndicator: true,
                autoplay: false,
                indicatorBgPadding: 1,

              ),
            ),
          ),
          Expanded(
            child: ListView(
              itemExtent: 50,


              children: [



                Card(
                    margin: EdgeInsets.only(right: 200,bottom: 5),
                    color: Colors.white,


                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(

                        children:[
                          Icon(
                            Icons.account_circle,
                            color: Color(0xff056674),
                          ),

                          Center(child: Text('Profil',style: TextStyle(
                              color: Color(0xff056674),fontSize: 18
                          ),)),

                        ],

                      ),
                    )
                ),
                Card(
                    margin: EdgeInsets.only(right: 200,bottom: 5),
                    color: Colors.white,

                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children:[
                          Icon(
                            Icons.settings,
                            color: Color(0xff056674),
                          ),

                          Center(child: Text('Parametres',style: TextStyle(
                              color: Color(0xff056674),fontSize: 18
                          ),)),

                        ],

                      ),
                    )
                ),

                Card(
                    margin: EdgeInsets.only(right: 200,bottom: 5),
                    color: Colors.white,


                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(

                        children:[
                          Icon(
                            Icons.announcement,
                            color: Color(0xff056674),
                          ),

                          Center(child: Text('News',style: TextStyle(
                              color: Color(0xff056674),fontSize: 18
                          ),)),


                        ],

                      ),
                    )
                ),
                Card(
                    margin: EdgeInsets.only(right: 200,bottom: 5),
                    color: Colors.white,


                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(

                        children:[
                          Icon(
                            Icons.monetization_on,
                            color: Color(0xff056674),
                          ),

                          Center(child: Text('Aider Neacti',style: TextStyle(
                              color: Color(0xff056674),fontSize: 18
                          ),)),


                        ],

                      ),
                    )
                ),



              ],




            ),
          ),

        ],

      )
      );

  }
}
