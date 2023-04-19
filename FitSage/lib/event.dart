class Event {
  String workoutName;
  String workoutMuscle;
  int day;
  int month;
  int year;
  int totalCalories;

  Event(
      {required this.workoutName,
      required this.workoutMuscle,
      required this.day,
      required this.month,
      required this.year,
      required this.totalCalories});

  Map<String, dynamic> toMap() {
    return {
      'workoutName': workoutName,
      'workoutMuscle': workoutMuscle,
      'day': day,
      'month': month,
      'year': year,
      'totalCalories': totalCalories,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      workoutName: map['workoutName'],
      workoutMuscle: map['workoutMuscle'],
      day: map['day'],
      month: map['month'],
      year: map['year'],
      totalCalories: map['totalCalories'],
    );
  }
}
