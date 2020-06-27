// エンティティモデル(インスタンスフィールド)
import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  Task(DocumentSnapshot doc) {
    documentID = doc.documentID;
    title = doc['title'];
  }
  String documentID;
  String title;
}
