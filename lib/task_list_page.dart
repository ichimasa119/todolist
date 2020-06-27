import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/task_list_model.dart';

class TaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ChangeNotifierProvider<TaskListModel>(
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
                  ),
                )
                .toList();
            return ListView(children: listTiles);
          }),
        ),
      ),
    );
  }
}
