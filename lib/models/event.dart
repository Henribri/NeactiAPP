import 'category.dart';
import 'address.dart';

/// Event model contain information about event
class Event {
  String id;
  String title;
  String dateTime ;
  EventAddress address;
  List<String> actPeople;
  int allPeople;
  String desc;
  Category category;
  String categoryRef;

  Event(this.id, this.title, this.dateTime, this.address, this.actPeople, this.allPeople, this.desc, this.category, this.categoryRef);


  /// Build event object based on Json
  factory Event.fromJson(Map<String, dynamic> parsedJson){

    var actPeopleFromJson = parsedJson['act_people'];
    List<String> actPeopleList = new List<String>.from(actPeopleFromJson);

    return Event(
        parsedJson['id'],
        parsedJson['title'],
        parsedJson['date_time'],
        EventAddress.fromJson(parsedJson['address']),
        actPeopleList,
        parsedJson['all_people'],
        parsedJson['description'],
        Category.fromJson(parsedJson['category']),
        null
    );

  }

  /// Convert event object to Json
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["title"] = title;
    map["date_time"] = dateTime;
    map["address"] = address.toMap();
    map["act_people"] = actPeople;
    map["all_people"] = allPeople;
    map["description"] = desc;
    map["category"] = categoryRef;

    return map;
  }




}
