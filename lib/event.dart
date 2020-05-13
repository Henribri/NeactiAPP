import 'package:http/http.dart';
import 'dart:convert';
import 'event_list.dart';

class Event {
  int id;
  String title;
  String subtitle;
  String date_time ;
  String address;
  int act_people;
  int all_people;
  String desc;
  String category;

  Event(this.id, this.title, this.subtitle, this.date_time, this.address, this.act_people, this.all_people, this.desc, this.category);







  Future<void> getData() async {
    Response response = await get(
        'http://10.0.2.2:8000/events/1');
    Map data = jsonDecode(response.body);
    this.desc = data['description'];
    print(this.desc);
  }
}
