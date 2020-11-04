/// Category specify type of event
/// It also contain information to display

class Category {
  String id;
  String name;
  int iconId;
  String fontFamily ;
  String fontPackage;


  Category(this.id, this.name, this.iconId, this.fontFamily, this.fontPackage);

  /// Build category based on Json
  factory Category.fromJson(Map<String, dynamic> parsedJson){

    return Category(
        parsedJson['id'],
        parsedJson['name'],
        parsedJson ['iconId'],
        parsedJson ['fontFamily'],
        parsedJson ['fontPackage']
    );
  }

}