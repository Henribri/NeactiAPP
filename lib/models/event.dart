import 'category.dart';

//-- EVENT MODEL CONTAIN INFORMATION ABOUT AN EVENT

class Event {
  String id;
  String title;
  String subtitle;
  String dateTime ;
  String address;
  List<String> actPeople;
  int allPeople;
  String desc;
  Category category;

  Event(this.id, this.title, this.subtitle, this.dateTime, this.address, this.actPeople, this.allPeople, this.desc, this.category);


  //-- BUILD EVENT OBJECT BASED ON JSON
  factory Event.fromJson(Map<String, dynamic> parsedJson){

    var actPeopleFromJson = parsedJson['act_people'];
    List<String> actPeopleList = new List<String>.from(actPeopleFromJson);

    return Event(
        parsedJson['id'],
        parsedJson['title'],
        parsedJson['subtitle'],
        parsedJson['date_time'],
        parsedJson['address'],
        actPeopleList,
        parsedJson['all_people'],
        parsedJson['description'],
        Category.fromJson(parsedJson['category'])
    );

  }


}

/*
class EventList{

  List<Event> events;

  EventList(this.events);

  factory EventList.fromJson(List<dynamic>parsedJson){
    List<Event> events = new List<Event>();
    events=parsedJson.map((i)=>Event.fromJson(i)).toList();
    return new EventList(
      events
    );
  }

}
*/