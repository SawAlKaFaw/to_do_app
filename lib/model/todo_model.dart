class ToDoModel {
  int? id;
  String? task;
  String? description;
  ToDoModel({required this.id, required this.task, required this.description});

  ToDoModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    task = map['task'];
    description = map['description'];
  }
  Map<String, dynamic> toMap() =>
      {"id": id, 'task': task, 'description': description};
}
