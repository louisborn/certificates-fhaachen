import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum DBError {
  NoError,
  Exception,
}

//* A provider for the access control of workspaces.
//*
//* Implements a [enterWorkspace()] and [leaveWorkspace()]
//* function to enter and leave a workspace
//*
class DatabaseProvider extends ChangeNotifier {
  String _dbException = '';
  static const String _WORKSPACE = "workspaces";

  DBError _errorStatus = DBError.NoError;
  DBError get errorStatus => _errorStatus;

  String get dbException => _dbException;
  set dbException(String exception) => this._dbException = exception;

  //* Enters a user to a workspace if the current number of users
  //* is not higher than the max number allowed.
  Future<void> enterWorkspace(String docId) async {
    var _docRef = getDocReference("");

    var currentAndMax = await getCurrentAndMaxInWorkspace(_docRef);
    if (checkUserCountInWorkspace(
      currentAndMax.elementAt(0),
      currentAndMax.elementAt(1),
    ))
      //Todo: Log a user and increment.
      print('ACCESS OK');
    else
      //Todo: Update status.
      print('ACCESS DENIED');
  }

  //* Returns a document reference based on the [id].
  DocumentReference getDocReference(String id) {
    DocumentReference _docRef = FirebaseFirestore.instance
        .collection(_WORKSPACE)
        //! Id string only for development. Remove and replace by [docId].
        .doc("9kU3kD1Bs9JlHmVbGtQu");

    return _docRef;
  }

  //* Returns the current and the max allowed users in a workspace as a iterable.
  //*
  //* Throws an [Exception] if the document snapshot could not be initialized.
  Future<Iterable> getCurrentAndMaxInWorkspace(DocumentReference docRef) async {
    try {
      DocumentSnapshot snapshot = await docRef.get();

      return [snapshot["currentInWorkspace"], snapshot["maxInWorkspace"]];
    } catch (exception) {
      catchDatabaseException(exception);
      return null;
    }
  }

  bool checkUserCountInWorkspace(int current, int max) {
    if (current < max)
      return true;
    else
      return false;
  }

  //* Increments the current user in workspace by +1.
  //*
  //* Throws an [Exception] if the update could not be conducted.
  Future<void> incrementUserInWorkspace(DocumentReference docRef) async {
    try {
      await docRef.update(
        {"currentInWorkspace": FieldValue.increment(1)},
      );
    } catch (exception) {
      catchDatabaseException(exception.toString());
    }
  }

  Future<void> leaveWorkspace(String docId) async {
    var _docRef = getDocReference("");
    decrementUserInWorkspace(_docRef);
  }

  //* Decrements the current user in a workspace by -1.
  //*
  //* Throws an [Exception] if the update could not be conducted.
  Future<void> decrementUserInWorkspace(DocumentReference docRef) async {
    try {
      await docRef.update(
        {"currentInWorkspace": FieldValue.increment(-1)},
      );
    } catch (exception) {
      catchDatabaseException(exception.toString());
    }
  }

  //* Catches any database exception and sets the [_errorStatus]
  //* with the exception information.
  void catchDatabaseException(String exception) {
    dbException = exception;

    _errorStatus = DBError.Exception;
    notifyListeners();
  }
}
