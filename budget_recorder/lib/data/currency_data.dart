class Currency {
  final String name, label;
  const Currency({
    required this.name,
    required this.label,
  });
}

String getLabelByName(String name) {
  String crrLabel = "Rs";
  for (var item in currenciesList) {
    if (item.name == name) {
      crrLabel = item.label;
    }
  }
  return crrLabel;
}

const List<Currency> currenciesList = [
  Currency(
    name: "LKR",
    label: "Rs",
  ),
  Currency(
    name: "USD",
    label: "\$",
  ),
  Currency(
    name: "GBP",
    label: "£",
  ),
  Currency(
    name: "YER",
    label: "﷼",
  ),
  Currency(
    name: "SGD",
    label: "\$",
  ),
  Currency(
    name: "AUD",
    label: "\$",
  ),
  Currency(
    name: "CAD",
    label: "\$",
  ),
];
