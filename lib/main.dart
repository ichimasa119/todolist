import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/task_list_page.dart';

import 'main_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Title_Page',
            ),
            backgroundColor: Colors.blueGrey,
          ),
          body: Consumer<MainModel>(builder: (context, model, child) {
            return Center(
              child: RaisedButton(
                child: Text('TaskListへ'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaskListPage()),
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
