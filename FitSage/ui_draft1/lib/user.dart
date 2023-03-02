
class User {
  int id;
  String name;
  double weight;
  double height;
  int age;
  String gender;

  User({required this.id, required this.name, required this.weight, required this.height, required this.age, required this.gender});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'height': height,
      'age': age,
      'gender': gender,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      weight: map['weight'],
      height: map['height'],
      age: map['age'],
      gender: map['gender'],
    );
  }
}