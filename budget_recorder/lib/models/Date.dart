class Date {
  String day, month, year;

  Date(this.day, this.month, this.year);

  static Date fromMap(Map map) {
    return Date(
      map['day'].toString(),
      map['month'].toString(),
      map['year'].toString(),
    );
  }

}
