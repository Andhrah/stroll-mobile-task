class SignupModel {
  final String id;
  final String name;

  SignupModel({required this.id, required this.name});

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
