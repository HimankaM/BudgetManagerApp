class Category {
  String cID, name, type, description;

  Category(this.cID, this.name, this.type, this.description);

  void setCID(String value){
    cID = value;
  }
  void setName(String value){
    name = value;
  }
  void setType(String value){
    type = value;
  }
  void setDescription(String value){
    description = value;
  }

  static Category fromMap(Map map) {
    return Category(map['_id'].toString(), map['name'].toString(),
        map['type'].toString(), map['description'].toString());
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": this.cID,
      "name": this.name,
      "type": this.type,
      "description": this.description,
    };
  }
}
