import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_task_model.dart';

class AddTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTaskModel>(
      create: (_) => AddTaskModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add_Task'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Consumer<AddTaskModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (text) {
                      model.taskTitle = text;
                    },
                  ),
                  RaisedButton(
                    child: Text('追加する'),
                    onPressed: () async {
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
}
