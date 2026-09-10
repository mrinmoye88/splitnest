class ChoreModel {
  final String id;
  final String title;
  final String assignedTo;
  final bool isDone;

  ChoreModel({
    required this.id,
    required this.title,
    required this.assignedTo,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'assignedTo': assignedTo,
      'isDone': isDone,
    };
  }

  factory ChoreModel.fromMap(String id, Map<String, dynamic> map) {
    return ChoreModel(
      id: id,
      title: map['title'] ?? '',
      assignedTo: map['assignedTo'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }
}