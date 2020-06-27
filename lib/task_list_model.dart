import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todolistapp/task.dart';

class TaskListModel extends ChangeNotifier {
  List<Task> tasks = [];
  Future fetchTasks() async {
    final docs = await Firestore.instance.collection('tasks').getDocuments();
    final tasks = docs.documents.map((doc) => Task(doc['title'])).toList();
    this.tasks = tasks;
    notifyListeners();
  }
}
