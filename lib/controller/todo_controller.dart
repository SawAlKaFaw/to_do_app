import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/todo_model.dart';

class ToDoController extends GetxController {
  static GetStorage box = GetStorage();
  RxList<ToDoModel> tasks = <ToDoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() {
    if (box.hasData("tasks")) {
      List storeTask = box.read("tasks");
      tasks.assignAll(storeTask.map((e) => ToDoModel.fromMap(e)).toList());
    }
  }

  void addTask(String task, String description) {
    int id = tasks.isNotEmpty ? tasks.last.id! + 1 : 1;
    tasks.add(ToDoModel(id: id, task: task, description: description));
    saveTasks();
  }

  void editTask(int id, String newTask, String newDescription) {
    final index = tasks.indexWhere((element) => element.id == id);
    tasks[index] =
        ToDoModel(id: id, task: newTask, description: newDescription);
    saveTasks();
  }

  void deleteTask(int id) {
    tasks.removeWhere((element) => element.id == id);
    saveTasks();
  }

  void clearAll() {
    tasks.clear();
    box.erase();
  }

  void saveTasks() {
    box.write("tasks", tasks.map((element) => element.toMap()).toList());
  }
}
