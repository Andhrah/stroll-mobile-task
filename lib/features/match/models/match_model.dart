class MatchModel {
  final String id;
  final String name;

  MatchModel({required this.id, required this.name});

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
