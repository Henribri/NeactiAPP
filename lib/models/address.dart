class EventAddress {

  String name;
  double lat;
  double lon ;
  String placeId;



  EventAddress(this.name, this.lat, this.lon, this.placeId);

  /// Build address of event object based on Json
  factory EventAddress.fromJson(Map<String, dynamic> parsedJson){


    return EventAddress(
        parsedJson['name'],
        parsedJson['lat'],
        parsedJson ['lon'],
        parsedJson ['placeId']
    );
  }

  /// Convert address object to Json
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["lat"] = lat;
    map["lon"] = lon;
    map["placeId"]=placeId;

    return map;
  }
}