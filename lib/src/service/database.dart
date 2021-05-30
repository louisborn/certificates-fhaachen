import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models.dart';
import '../../services.dart';

class Document<T> {
  Document({this.path}) {
    this.ref = _db.doc(path!);
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String? path;
  DocumentReference? ref;

  Future<DocumentSnapshot> getDocumentSnapshot() {
    return ref!.get();
  }

  Future<T> getData() {
    return ref!.get().then((value) => Global.models[T](value.data()) as T);
  }
}

class Collection<T> {
  Collection({this.path}) {
    this.ref = _db.collection(path!);
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String? path;

  CollectionReference? ref;

  Future<List<T>> getData() async {
    var snapshots = await ref!.get().then((value) =>
        value.docs.map((doc) => Global.models[T](doc.data()) as T).toList());
    return snapshots;
  }

  Future<List<T>> getDataQueriedById() async {
    var snapshots = await ref!
        .where(
          'studentId',
          isEqualTo: PreferenceService().getString('studentId'),
        )
        .get()
        .then((value) => value.docs
            .map((doc) => Global.models[T](doc.data()) as T)
            .toList());
    return snapshots;
  }
}
