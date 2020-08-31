class EventAddress {

  String name;
  double lat;
  double lon ;
  String placeId;



  EventAddress(this.name, this.lat, this.lon, this.placeId);

  //-- BUILD ADDRESS OF EVENT OBJECT BASED ON JSON

  factory EventAddress.fromJson(Map<String, dynamic> parsedJson){

    return EventAddress(
        parsedJson['name'],
        parsedJson['lat'],
        parsedJson ['lon'],
        parsedJson ['placeId']
    );
  }


  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["lat"] = lat;
    map["lon"] = lon;
    map["placeId"]=placeId;

    return map;
  }
}