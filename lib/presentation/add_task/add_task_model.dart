import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AddTaskModel extends ChangeNotifier {
  String taskTitle = '';
  Future addTaskToFirebase() async {
    if (taskTitle.isEmpty) {
      throw ('タスクを入力してください');
    }

    Firestore.instance.collection('tasks').add({
      'title': taskTitle,
    });
  }
}
