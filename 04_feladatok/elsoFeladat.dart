import 'dart:io';

void main() {
  print("Adjon meg egy számot: ");
  int? numberInput = int.parse(stdin.readLineSync()!);

  if (numberInput % 2 == 0) {
    print("A szám páros");
  } else {
    print("A szám páratlan");
  }

  if (numberInput == 1) {
    print("Elégtelen");
  } else if (numberInput == 2) {
    print("Elégséges");
  } else if (numberInput == 3) {
    print("Közepes");
  } else if (numberInput == 4) {
    print("Jó");
  } else if (numberInput == 5) {
    print("Jeles");
  } else {
    print("Érvénytelen osztályzat");
  }

  switch (numberInput) {
    case 1:
      print("Elégtelen");
      break;
    case 2:
      print("Elégséges");
      break;
    case 3:
      print("Közepes");
      break;
    case 4:
      print("Jó");
      break;
    case 5:
      print("Jeles");
      break;
    default:
      print("Érvénytelen osztályzat");
      break;
  }

  assert(1 > numberInput || numberInput > 5, "Érvénytelen osztályzat");

  
}
