import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/models/task_model.dart';

class TasksService extends ChangeNotifier {
  List<Task> tasks = [];
  bool isLoading = true;
  bool isSaving = false;
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  TasksService() {
    getTasks();
  }

  //Get tasks with firebase
  Future<void> getTasks() async {
    isLoading = true;
    notifyListeners();
    try {
      //Get products
      CollectionReference collectionReference = _instance.collection('tasks');
      QuerySnapshot tasksDocs = await collectionReference.get();

      if (tasksDocs.docs.isNotEmpty) {
        for (DocumentSnapshot  task in tasksDocs.docs) {
          final newTask = Task.fromMap(task.data() as Map<String,dynamic>);
          newTask.idTask = task.id;
          tasks.add(newTask);
        }
      }
      isLoading = false;
      notifyListeners();
    } catch (ex) {
      print("Error al obtener las tareas");
    }
  }

  //Save task with firebase
  Future<void> saveTask(Task task) async {
    isSaving = true;
    notifyListeners();
    try {
      //Save task
      CollectionReference collectionReference = _instance.collection('tasks');
      final res = await collectionReference.add(task.toMap());
      task.idTask = res.id;
      tasks.add(task);
    } catch (ex) {
      print("Error al guardar la tarea");
    }
    isSaving = false;
    notifyListeners();
  }

  //Delete task with firebase
  Future<void> deleteTask(Task task) async {
    try {
      //Delete task
      CollectionReference collectionReference = _instance.collection('tasks');
      await collectionReference.doc(task.idTask).delete();
      tasks.remove(task);
      notifyListeners();
    } catch (ex) {
      print("Error al eliminar la tarea");
    }
  }

  //Delete all tasks with firebase
  Future<void> deleteAllTasks() async {
    try {
      //Delete all tasks
      CollectionReference collectionReference = _instance.collection('tasks');
      await collectionReference.get().then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
      tasks.clear();
      notifyListeners();
    } catch (ex) {
      print("Error al eliminar todas las tareas");
    }
  }

  //Update task with firebase
  Future<void> updateTask(Task task) async {
    try {
      //Update task
      CollectionReference collectionReference = _instance.collection('tasks');
      await collectionReference.doc(task.idTask).update(task.toMap());
      //Actualizar la tarea en la lista
      final index = tasks.indexWhere((element) => element.idTask == task.idTask);
      tasks[index] = task;
      
      notifyListeners();
    } catch (ex) {
      print("Error al actualizar la tarea");
    }
  }

  //Get task with firebase
  Future<Task?> getTask(String idTask) async {
    try {
      //Get task
      CollectionReference collectionReference = _instance.collection('tasks');
      DocumentSnapshot taskDoc = await collectionReference.doc(idTask).get();
      final task = Task.fromMap(taskDoc.data() as Map<String,dynamic>);
      task.idTask = taskDoc.id;
      return task;
    } catch (ex) {
      print("Error al obtener la tarea");
      return null;
    }
  }

}
