import 'package:http/http.dart';
import 'dart:convert';
import 'event.dart';

class EventList {
  int Id;
  List<Event> Event_List = [];

  EventList() {
    getData();
  }

  EventList.Exact(this.Id) {
    getDataById();
  }

  Future<void> getData() async {
    print('aie');
    Response response = await get('http://10.0.2.2:8000/events.json');
    List<dynamic> data = jsonDecode(response.body);
    for (var event in data){

      Event _event = Event(event['id'], event['title'], event['subtitle'], event['date_time'],event['address'], event['act_people'],  event['all_people'], event['description'], event['category']);
      this.Event_List.add(_event);

    }

print(Event_List);

  }
}

Future<void> getDataById() async {
  Response response = await get(
      'http://10.0.2.2:8000/events/1');
  Map data = jsonDecode(response.body);
  //this.desc = data['description'];
 // print(this.desc);
}

