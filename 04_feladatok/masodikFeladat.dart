import 'dart:io';

void main() {
  print("Adjon meg egy számot:");
  int? firstNumber = int.parse(stdin.readLineSync()!);

  print("Adjon meg még egy számot:");
  int? secondNumber = int.parse(stdin.readLineSync()!);

  if (firstNumber > secondNumber) {
    int difference = firstNumber - secondNumber;
    print(
        "A nagyobbik szám a $firstNumber és a két szám közötti különbség $difference");
  } else if (firstNumber < secondNumber) {
    int difference = secondNumber - firstNumber;
    print(
        "A nagyobbik szám a $secondNumber és a két szám közötti különbség $difference");
  } else {
    print("A két szám egyenlő");
  }
}
