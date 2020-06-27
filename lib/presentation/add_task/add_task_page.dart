import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/domain/task.dart';

import 'add_task_model.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({this.task});
  final Task task;
  @override
  Widget build(BuildContext context) {
    final bool isUpdate = task != null;
    final textEditingController = TextEditingController();
    if (isUpdate) {
      textEditingController.text = task.title;
    }

    return ChangeNotifierProvider<AddTaskModel>(
      create: (_) => AddTaskModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? '本を編集' : '本を追加'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Consumer<AddTaskModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: textEditingController,
                    onChanged: (text) {
                      model.taskTitle = text;
                    },
                  ),
                  RaisedButton(
                    child: Text(isUpdate ? '更新' : '追加'),
                    onPressed: () async {
                      if (isUpdate) {
                        // タスクを更新
                        await updateTask(model, context);
                      } else {
                        // タスクを追加
                        await addTask(model, context);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future addTask(AddTaskModel model, BuildContext context) async {
    try {
      // todo: firestoreにタスクを追加
      await model.addTaskToFirebase();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('保存しました'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future updateTask(AddTaskModel model, BuildContext context) async {
    try {
      // todo: firestoreにタスクを追加
      await model.updateTask(task);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('更新しました'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
