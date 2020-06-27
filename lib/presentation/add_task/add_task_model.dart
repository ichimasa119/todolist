import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todolistapp/domain/task.dart';

class AddTaskModel extends ChangeNotifier {
  String taskTitle = '';
  Future addTaskToFirebase() async {
    // バリデーション(空文字判定)
    if (taskTitle.isEmpty) {
      throw ('タスクを入力してください');
    }

    // Insert
    Firestore.instance.collection('tasks').add({
      'title': taskTitle,
      'createAt': Timestamp.now(),
    });
  }

  Future updateTask(Task task) async {
    final document =
        Firestore.instance.collection('tasks').document(task.documentID);
    await document.updateData({
      'title': taskTitle,
      'updateAt': Timestamp.now(),
    });
  }
}
