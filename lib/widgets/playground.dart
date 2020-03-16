const WEEKDAY = "weekday";
const AMOUNT = "amount";

main() {
  print("inside new main");
  List <Map<dynamic, dynamic>> trans = [
    {"weekday": "Mon", "amount": 1100.0},
    {"weekday": "Tue", "amount": 300.0},
    {"weekday": "Wed", "amount": 400.0},
    {"weekday": "Thu", "amount": 500.0},
    {"weekday": "Fri", "amount": 600.0},
    {"weekday": "Sat", "amount": 700.0},
    {"weekday": "Sun", "amount": 800.0}
  ];
  getMaximumTransactionValue(trans);
}

double getMaximumTransactionValue(List<Map> trans) {
  List<double> arrayOfAmounts = [];
  for (var map in trans) {
    arrayOfAmounts.add((map[AMOUNT]));
  }
  double max = arrayOfAmounts.reduce((current, next) => (current > next) ? current : next);
  return max;
}
