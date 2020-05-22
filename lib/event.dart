import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';


class Event {
  String id;
  String title;
  String subtitle;
  String dateTime ;
  String address;
  List actPeople;
  int allPeople;
  String desc;
  String category;

  Event(this.id, this.title, this.subtitle, this.dateTime, this.address, this.actPeople, this.allPeople, this.desc, this.category);


}
