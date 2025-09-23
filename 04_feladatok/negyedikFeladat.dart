import 'dart:io';

void main() {
  print("Adja meg a teszt össz pontszámát:");
  int? totalPoints = int.parse(stdin.readLineSync()!);

  print("Adja meg az elért pontszámot:");
  int? achievedPoints = int.parse(stdin.readLineSync()!);

  int percentageValue = ((achievedPoints / totalPoints) * 100).toInt();

  if (90 <= percentageValue && percentageValue <= 100) {
    print('A');
  } else if (80 <= percentageValue && percentageValue < 90) {
    print('B');
  } else if (70 <= percentageValue && percentageValue < 80) {
    print('C');
  } else if (60 <= percentageValue && percentageValue < 70) {
    print('D');
  } else if (50 <= percentageValue && percentageValue < 60) {
    print('E');
  } else {
    print('F');
  }
}
