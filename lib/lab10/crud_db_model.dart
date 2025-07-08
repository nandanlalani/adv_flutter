class Student {
  int? id;
  String name;

  Student({this.id, required this.name});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
    );
  }
}
