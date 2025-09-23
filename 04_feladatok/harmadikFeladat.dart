import 'dart:io';
import 'dart:math';

void main() {
  print("Adjon meg egy számot:");
  int? numberValue = int.parse(stdin.readLineSync()!);

  if (numberValue % 2 == 0) {
    print("A szám páros");
  } else {
    print("A szám páratlan");
  }

  if (numberValue < 0) {
    print("A szám negatív");
    print("A szám nem négyzetszám");
  } else if (numberValue == 0) {
    print("A szám nulla");
    print("A szám négyzetszám");
  } else {
    print("A szám pozitív");
    if (sqrt(numberValue) * sqrt(numberValue) == numberValue) {
      print("A szám négyzetszám");
    } else {
      print("A szám nem négyzetszám");
    }
  }
}
