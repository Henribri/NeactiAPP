//-- CATEGORY SPECIFY THE TYPE OF AN EVENT
//-- IT ALSO CONTAINS INFORMATION TO DISPLAY

class Category {
  String id;
  String name;
  int iconId;
  String fontFamily ;
  String fontPackage;


  Category(this.id, this.name, this.iconId, this.fontFamily, this.fontPackage);

  //-- BUILD CATEGORY OBJECT BASED ON JSON

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