void main() {
  int intValue = 23;
  double doubleValue = 10.42;
  String stringValue = "jobless bum babri";
  bool boolValue = true;

  int intResult = intValue * 5;
  double doubleResult = doubleValue / 0.54;

  //intResult érték kiíratása
  print("Az integer értéke $intResult");
  
  //doubleResult érték kiíratása
  print("A double értéke $doubleResult");

  

  bool boolResult = !boolValue;

  //boolResult értéke (boolValue negáltja)
  print("A boolResult értéke $boolResult");
}
