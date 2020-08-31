class EventAddress {

  String name;
  double lat;
  double lon ;



  EventAddress(this.name, this.lat, this.lon);

  //-- BUILD ADDRESS OF EVENT OBJECT BASED ON JSON

  factory EventAddress.fromJson(Map<String, dynamic> parsedJson){

    return EventAddress(
        parsedJson['name'],
        parsedJson['lat'],
        parsedJson ['lon']
    );
  }


  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["lat"] = lat;
    map["lon"] = lon;

    return map;
  }
}