import 'dart:io';

void main(){

    //1. Kérj be két (legfeljebb kétjegyű) egész számot!
    //A kisebbtől a nagyobbik írasd ki a számokat és írd mellé, hogy páros, vagy páratlan a szám!
    int? firstNumber;
    int? secondNumber;

    while(firstNumber == null || firstNumber < -99 || firstNumber > 99){
      print("Kérem az első számot: ");
      firstNumber = int.tryParse(stdin.readLineSync()!);
    }
    while(secondNumber == null || secondNumber < -99 || secondNumber > 99){
      print("Kérem az második számot: ");
      secondNumber = int.tryParse(stdin.readLineSync()!);
    }
    
    if (firstNumber > secondNumber) {
      int temp = firstNumber;
      firstNumber = secondNumber;
      secondNumber = temp;
    }

    for (int i = firstNumber; i <= secondNumber; i++) {
      if (i % 2 == 0) {
        print("$i Páros");
      } else {
        print("$i Páratlan");
      }
    }
}