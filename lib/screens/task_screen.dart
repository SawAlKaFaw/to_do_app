import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../controller/todo_controller.dart';
import '../model/todo_model.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});
  final ToDoController toDoController = Get.put(ToDoController());

  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        //backgroundColor: Colors.white,
        title: const Text(
          "To Do List",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton.icon(
              label: const Text(
                "Log Out",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                AuthenicationController.authenicationController.logOut();
                toDoController.clearAll();
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.black,
              )),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => ListView.builder(
            itemCount: toDoController.tasks.length,
            itemBuilder: (context, index) {
              ToDoModel task = toDoController.tasks[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  tileColor: Colors.yellow[100],
                  leading: const Icon(Icons.add_task_outlined),
                  title: Text(
                    task.task!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    task.description!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                        onPressed: () {
                          taskController.text = task.task!;
                          descriptionController.text = task.description!;

                          Get.defaultDialog(
                              title: "Edit Task",
                              confirmTextColor: Colors.white,
                              cancelTextColor: Colors.blue,
                              onCancel: () {},
                              onConfirm: () {
                                if (taskController.text.isNotEmpty &&
                                    descriptionController.text.isNotEmpty) {
                                  toDoController.editTask(
                                      task.id!,
                                      taskController.text,
                                      descriptionController.text);
                                  taskController.clear();
                                  descriptionController.clear();

                                  Get.back();
                                }
                              },
                              content: textFieldWidget());
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          toDoController.deleteTask(task.id!);
                        },
                        icon: const Icon(Icons.delete)),
                  ]),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          displayDialog(title: "Add Your Task.");
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> displayDialog({required String title}) {
    return Get.defaultDialog(
        title: title,
        onCancel: () {},
        confirmTextColor: Colors.white,
        onConfirm: () {
          if (taskController.text.isNotEmpty &&
              descriptionController.text.isNotEmpty) {
            toDoController.addTask(
                taskController.text, descriptionController.text);
            taskController.clear();
            descriptionController.clear();
            Get.back();
          }
        },
        content: textFieldWidget());
  }

//TextField in Dialog Box
  Column textFieldWidget() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
              hintText: "Add Your Task",
              fillColor: Colors.yellow[200],
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          controller: taskController,
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(
            hintText: "Description",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            fillColor: Colors.yellow[200],
            filled: true,
          ),
        ),
      ],
    );
  }
}
