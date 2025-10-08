import "dart:io";

void main() {
  print("Kérem adjon meg egy számot: ");
  int? numberValue = int.tryParse(stdin.readLineSync()!);

  List<int> digits = numberValue.toString().split('').map(int.parse).toList();

  for (int digit in digits) {
    int digitPower = digit * digit;

    print("A ${digit} négyzete: ${digitPower}");
  }
}
