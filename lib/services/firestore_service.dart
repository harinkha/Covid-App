import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidapp/models/taskModel.dart';

class FirestoreService {
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  Future getTasks() async {
    var snap = tasks.snapshots();
    return snap.toList();
  }
}
