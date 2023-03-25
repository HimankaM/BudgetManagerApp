class Account {
  String accID, name, description;
  double amount;

  Account(this.accID, this.name, this.amount, this.description);

  void setAccID(String val) {
    accID = val;
  }

  void setAccName(String val) {
    name = val;
  }

  void setAccBalance(double val) {
    amount = val;
  }

  void setAccDescription(String val) {
    description = val;
  }

  static Account fromMap(Map map) {
    return Account(
      map['_id'].toString(),
      map['name'].toString(),
      double.parse(map['amount'].toString()),
      map['description'].toString(),
    );
  }
}
