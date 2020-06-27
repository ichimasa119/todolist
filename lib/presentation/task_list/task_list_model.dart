import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todolistapp/domain/task.dart';

class TaskListModel extends ChangeNotifier {
  List<Task> tasks = [];

  // Firebaseからデータを抽出
  Future fetchTasks() async {
    final docs = await Firestore.instance.collection('tasks').getDocuments();
    final tasks = docs.documents.map((doc) => Task(doc)).toList();
    this.tasks = tasks;
    notifyListeners();
  }

  // Firebaseからデータを削除
  Future deleteTask(Task task) async {
    await Firestore.instance
        .collection('tasks')
        .document(task.documentID)
        .delete();
  }
}
