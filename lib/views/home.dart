import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neacti/buisness_logic/models/apiUrl.dart';
import 'package:carousel_pro/carousel_pro.dart';


class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [

          /// Different tab
          Padding(
            padding: EdgeInsets.only(top:10, left: 20, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bienvenue !',
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,fontFamily: 'Rob', fontStyle: FontStyle.italic),
              ),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width-50,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Profil', style: Theme.of(context).textTheme.headline3,),
                    Icon(Icons.account_circle, size: 20, color: Theme.of(context).primaryColorDark,)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height:5),

          Container(
            width: MediaQuery.of(context).size.width-50,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nous soutenir', style: Theme.of(context).textTheme.headline3,),
                    Icon(FontAwesomeIcons.thumbsUp, size: 20, color: Theme.of(context).primaryColorDark,)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height:5),

          FlatButton(
            onPressed: (){
              Navigator.pushNamed(context, '/profil/settings');
            },
            child: Container(
              width: MediaQuery.of(context).size.width-50,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Paramètres', style: Theme.of(context).textTheme.headline3,),
                      Icon(Icons.settings, size: 20, color: Theme.of(context).primaryColorDark,)
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height:5),

          SizedBox(height:10),

          Divider(
            color: Color(0xffff4b5c),
            thickness: 2,
            endIndent: 100,
            indent: 100,
          ),



          /// Neacti TV
          Padding(
            padding: EdgeInsets.only(top:15, left: 20, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'NeactiTV',
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 20,
                    fontFamily: 'Rob',),
              ),
            ),
          ),

          Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              margin: EdgeInsets.fromLTRB(10,2,10,0 ),
              width: MediaQuery.of(context).size.width*0.80,
              height: 200,
              child: Carousel(
              borderRadius: true,

                images: [
                  NetworkImage(
                      'https://i.ibb.co/PzXRNkT/Infos-Neacti.png'),
                  NetworkImage(
                      'https://i.ibb.co/F6JwT98/Infos-Neacti2.png'),
                  NetworkImage(
                      'https://i.ibb.co/vsd4nhJ/Infos-Neacti3.png'),
                ],
                showIndicator: true,
                autoplay: true,
                autoplayDuration: Duration(seconds: 8),
                indicatorBgPadding: 1,
              ),
            ),
          ),
          SizedBox(height: 80,)


        ],
      ),
    ));
  }
}
