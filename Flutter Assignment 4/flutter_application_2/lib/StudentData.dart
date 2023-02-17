class Student {
  final int id;
  final String name;
  final int age;

  const Student({
    required this.id,
    required this.name,
    required this.age,
  });
   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
   }
}