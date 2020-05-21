import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';


class Event {
  int id;
  String title;
  String subtitle;
  String dateTime ;
  String address;
  int actPeople;
  int allPeople;
  String desc;
  int category;

  Event(this.id, this.title, this.subtitle, this.dateTime, this.address, this.actPeople, this.allPeople, this.desc, this.category);


}
