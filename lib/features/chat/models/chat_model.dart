class ChatModel {
  final String id;
  final String name;

  ChatModel({required this.id, required this.name});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
