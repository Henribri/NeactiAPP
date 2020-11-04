abstract class ActivityEvent {}


/// Event to get data
class ActivityEventGet extends ActivityEvent{

  String uid;
  bool joinPage;

  ActivityEventGet({this.uid, this.joinPage});

}


/// Event when request for put/patch data
class ActivityEventPatch extends ActivityEvent{

  String uid;
  String eventId;
  List<String> newActPeople;
  bool joinPage;


  ActivityEventPatch({this.uid, this.eventId, this.newActPeople, this.joinPage});


}