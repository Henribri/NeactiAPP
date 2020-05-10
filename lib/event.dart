import 'package:http/http.dart';
import 'dart:convert';

class Event {
  String title='Tournoi Smash';
  String message= 'Ramenez vos manettes';
  String date = "15-05-2020";
  String time = "16:30";
  String address = '7 rue du marais';
  String group= '10/14';
  String desc = 'Chargement';

  Event() {
    getData();
    }

  Future<void> getData() async {
    Response response = await get(
        'http://10.0.2.2:8000/events/1');
    Map data = jsonDecode(response.body);
    this.desc = data['description'];
    print(this.desc);
  }
}