class User {
  final int id;
  final String? name;
  final int? age;

  User({
    required this.id,
    this.name,
    this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, age: $age}';
  }
}
