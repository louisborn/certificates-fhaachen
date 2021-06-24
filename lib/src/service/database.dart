import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services.dart';

/// A class to get a single [Document] from the backend.
///
class Document<T> {
  /// Creates a [Document]
  ///
  /// The [path] is the path to the documents location.
  ///
  Document({this.path}) {
    this.ref = _db.doc(path!);
  }

  /// The Cloud Firestore instance.
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// The path to the document.
  final String? path;

  /// The reference of the document.
  DocumentReference? ref;

  /// Returns a document snapshot.
  Future<DocumentSnapshot> getDocumentSnapshot() {
    return ref!.get();
  }

  /// Returns the data of the fetched document in a model object.
  Future<T> getData() {
    return ref!.get().then((value) => Global.models[T](value.data()) as T);
  }
}

/// A class to get a list of a [Collection].
///
class Collection<T> {
  /// Creates a [Collection].
  ///
  /// The [path] is the path to the collection locations.
  ///
  Collection({this.path}) {
    this.ref = _db.collection(path!);
  }

  /// The Cloud Firestore instance.
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// The path to the collection.
  final String? path;

  /// The collection reference.
  CollectionReference? ref;

  /// Returns a list of the fetched data as a model objcet.
  Future<List<T>> getData() async {
    var snapshots = await ref!.get().then(
          (value) => value.docs
              .map((doc) => Global.models[T](doc.data()) as T)
              .toList(),
        );
    return snapshots;
  }

  /// Returns a queried list by id of the fetched data as a model object.
  ///
  /// The [field] is the id that is compared to whether it is equal
  /// or not to the user`s current student id.
  ///
  Future<List<T>> getDataQueriedById(String field) async {
    var snapshots = await ref!
        .where(
          field,
          isEqualTo: PreferenceService().getString('studentId'),
        )
        .get()
        .then(
          (value) => value.docs
              .map((doc) => Global.models[T](
                    doc.data(),
                  ) as T)
              .toList(),
        );
    return snapshots;
  }
}
