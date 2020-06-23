class Repository {
  List<Day> getDaysList() => [
    new Day("Day 1", [
      new Exercise("Down for 5 seconds ", 5),
      new Exercise("Down for 10 seconds", 10),
      new Exercise("Down while you take 1 step back and return", 0),
      new Exercise("Down for 10 seconds", 10),
    ]),
    new Day("Day 2", [
      new Exercise("2Down for 5 seconds ", 5),
      new Exercise("2Down for 10 seconds", 10),
      new Exercise("2Down while you take 1 step back and return", 0),
      new Exercise("2Down for 10 seconds", 10),
    ]),
    new Day("Day 3", [
      new Exercise("3Down for 5 seconds ", 5),
      new Exercise("3Down for 10 seconds", 10),
      new Exercise("3Down while you take 1 step back and return", 0),
      new Exercise("3Down for 10 seconds", 10),
    ]),
  ];

  // void save() {}
}

class Exercise {
  String title = "";
  int timeSec = 0;
  Exercise(this.title, this.timeSec);
}

class Day {
  String title;
  List<Exercise> ExerciseList;
  Day(this.title, this.ExerciseList);
}

