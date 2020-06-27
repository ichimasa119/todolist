import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/domain/task.dart';
import 'package:todolistapp/presentation/add_task/add_task_page.dart';
import 'package:todolistapp/presentation/task_list/task_list_model.dart';

class TaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskListModel>(
      create: (_) => TaskListModel()
        ..fetchTasks(), // task_list_pageが表示された際にfetchTasksを実行する
      child: Scaffold(
        appBar: AppBar(
          title: Text('Task_List'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Consumer<TaskListModel>(builder: (context, model, child) {
          final tasks = model.tasks;
          final listTiles = tasks
              .map(
                (task) => ListTile(
                  title: Text(task.title),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      // todo : add_task_page
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTaskPage(
                            task: task,
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                      model.fetchTasks(); // リアルタイムに反映させる
                    },
                  ),
                  onLongPress: () async {
                    // TODO: 長押しでタスク削除
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('${task.title}を削除しますか'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('OK'),
                              onPressed: () async {
                                Navigator.of(context).pop();

                                // TODO : 削除のAPIを叩く
                                await deleteTask(context, model, task);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              )
              .toList();
          return ListView(children: listTiles);
        }),
        floatingActionButton:
            Consumer<TaskListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskPage(),
                  fullscreenDialog: true,
                ),
              );
              model.fetchTasks(); // リアルタイムに反映させる
            },
          );
        }),
      ),
    );
  }

  Future deleteTask(
      BuildContext context, TaskListModel model, Task task) async {
    try {
      // todo: firestoreにタスクを削除
      await model.deleteTask(task);
      await model.fetchTasks();
    } catch (e) {
      // await _showDialog(context, e.toString());
      print(e.toString());
    }
  }
}
