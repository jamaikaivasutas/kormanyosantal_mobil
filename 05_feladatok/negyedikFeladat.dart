import "dart:io";

void main() {
  print("Adjon meg egy számot: ");
  int? numberValue = int.tryParse(stdin.readLineSync()!);

  List<int> digits = numberValue.toString().split('').map(int.parse).toList();

  double digitAverage = digits.reduce((a, b) => a + b) / digits.length;

  print("A szám számjegyeinek átlaga: ${digitAverage.toStringAsFixed(2)}");
}
