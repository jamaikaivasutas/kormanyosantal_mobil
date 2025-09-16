void main() {
  String poem = '''Hattyúk a falvédőn,
  priccsre csorog a giccs.
  vadász elől félőn
  szökell egy szarvas is.''';
  print("$poem\n");
  print("${poem.toLowerCase()}\n");
  print("${poem.toUpperCase()}\n");
  print("${poem.replaceAll(" ", "-")}\n");
  print(" ...${poem.substring(5)}\n");
  print("${poem.substring(1, 3).codeUnits}\n");
  print("${poem.substring(10)} ...");
}
