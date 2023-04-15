class Event {
  int id;
  String workoutName;
  String workoutMuscle;
  int day;
  int month;
  int year;

  Event(
      {required this.id,
      required this.workoutName,
      required this.workoutMuscle,
      required this.day,
      required this.month,
      required this.year});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workoutName': workoutName,
      'workoutMuscle': workoutMuscle,
      'day': day,
      'month': month,
      'year': year,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      workoutName: map['workoutName'],
      workoutMuscle: map['workoutMuscle'],
      day: map['day'],
      month: map['month'],
      year: map['year'],
    );
  }
}
