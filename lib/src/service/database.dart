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
}

class User {
  User({
    required this.id,
  });

  final String id;

  /// The api uri for the database.
  static const String api =
      'https://mis21-61b88-default-rtdb.europe-west1.firebasedatabase.app/studentprofile/';

  Future<Student> getStudent() async {
    try {
      print(this.id);
      final http.Response response = await http.get(
        Uri.parse("$api$id.json"),
      );
      if (response.statusCode == 200) {
        return Global.models[Student](jsonDecode(response.body));
      } else
        throw Exception('Failed to get user data2');
    } catch (exception) {
      throw Exception('Failed to get user data');
    }
  }
}
