void main() {
  int ninthGradePeopleAmount = 4 * 28;
  int everyOtherGradePeopleAmount = 3 * 28;
  int sumOfEveryClass =
      ninthGradePeopleAmount + (everyOtherGradePeopleAmount * 4);

  print("A kilencedik osztályosok $ninthGradePeopleAmount-an/en vannak");
  print("A tizedik osztályosok $everyOtherGradePeopleAmount-an/en vannak");
  print("A tizenegyedik osztályosok $everyOtherGradePeopleAmount-an/en vannak");
  print(
      "A tizenkettedik osztályosok $everyOtherGradePeopleAmount-an/en vannak");
  print(
      "A tizenharmadik osztályosok $everyOtherGradePeopleAmount-an/en vannak");
  print("Összesen $sumOfEveryClass-an/en járnak az iskolába");
}
