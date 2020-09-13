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
          SizedBox(height: 10,),

          Padding(
            padding: EdgeInsets.all(10),
            child: Align(

              alignment: Alignment.centerLeft,
              child: Text(
                'Les News :',
                style: TextStyle(
                    color: Color(0xff056674),fontSize: 24, fontWeight: FontWeight.bold
                ),


              ),
            ),
          ),
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
                    color: Color(0xff056674),fontSize: 24, fontWeight: FontWeight.bold
                ),


              ),
            ),
          ),

                SizedBox(height: 10,),

                Expanded(
                  child: Container(

                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      itemExtent: 100,
                      children: [
                        Container(


                          child: Column(
                            children:[
                              Icon(
                                Icons.account_circle,
                                color: Color(0xff056674),
                                size: 32,
                              ),

                              Center(child: Text('Profil',style: TextStyle(
                                  color: Color(0xff056674),fontSize: 18
                              ),)),
                            ]


                          ),
                        ),


                        Container(

                          child: Column(
                            children: [
                              Icon(
                                Icons.announcement,
                                color: Color(0xff056674),
                                size: 32,
                              ),

                            Center(child: Text('News',style: TextStyle(
                                color: Color(0xff056674),fontSize: 18
                            ),)),

                            ],
                          ),
                        ),

                        Container(

                          child:
                          Column(
                            children: [
                              Icon(
                                Icons.monetization_on,
                                color: Color(0xff056674),
                                size: 32,
                              ),

                              Center(child: Text('Don',style: TextStyle(
                                  color: Color(0xff056674),fontSize: 18
                              ),)),
                            ],
                          ),
                        ),
                        Container(

                          child:
                          Column(
                            children: [
                              Icon(
                                Icons.settings,
                                color: Color(0xff056674),
                                size: 32,
                              ),

                              Center(child: Text('Parametres',style: TextStyle(
                                  color: Color(0xff056674),fontSize: 18
                              ),)),
                            ],
                          ),
                        )

                      ],

                    ),

                  ),
                ),










        ],

      )
      );

  }
}
