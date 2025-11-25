void main() {
  Map<String, List<String>> weekMap = {
    "Monday": ["Math", "Physics", "Chemistry"],
    "Tuesday": ["Biology", "History", "Geography"],
    "Wednesday": ["English", "Art", "Physical Education"],
    "Thursday": ["Computer Science", "Economics", "Music"],
    "Friday": ["Philosophy", "Sociology", "Drama"],
    "Saturday": ["Chill" , "Have hella fun with binaj"],
    "Sunday": ["Rest", "Prepare for the week ahead"],
  };

  print(weekMap.keys.toList());
  print(weekMap.values.toList());

  weekMap['Wednesday'] = ["workday", "remote workday", "national holiday"];
  weekMap['Saturday'] = [];

  weekMap.removeWhere((key, value) => value.isEmpty);  

  print(weekMap.keys);
  print(weekMap.values);
  }

