class BonfireModel {
  final String id;
  final String name;

  BonfireModel({required this.id, required this.name});

  factory BonfireModel.fromJson(Map<String, dynamic> json) {
    return BonfireModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
