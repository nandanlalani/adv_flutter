class FlagModel {
  String id;
  String name;

  FlagModel({required this.id, required this.name});

  factory FlagModel.fromJson(Map<String, dynamic> json) {
    return FlagModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
