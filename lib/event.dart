import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';


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


}
