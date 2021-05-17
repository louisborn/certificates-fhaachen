import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:certificates/providers/providers.dart';

enum UserAccessStatus {
  NotEntered,
  Entered,
  Left,
  Denied,
}

enum DatabaseErrorStatus {
  NoError,
  Exception,
}

/// [Update class documentation]
///
///
class DatabaseProvider extends ChangeNotifier {
  String _dbException = '';

  static const String _WORKSPACE = "workspaces";
  static const String _LOG = "log";

  DatabaseErrorStatus _errorStatus = DatabaseErrorStatus.NoError;
  DatabaseErrorStatus get errorStatus => _errorStatus;

  UserAccessStatus _userAccessStatus = UserAccessStatus.NotEntered;
  UserAccessStatus get userAccessStatus => _userAccessStatus;

  String get dbException => _dbException;
  set dbException(String exception) => this._dbException = exception;

  /// Logs/ enters a user to a workspace if the current number of users
  /// is not higher than the max number allowed.
  Future<void> enterWorkspace(String docId) async {
    //! Exchange "" with var id.
    var _docRef = getDocReference("");

    try {
      var workspaceInformation = await getWorkspaceInformation(_docRef);
      if (checkUserCountInWorkspace(
        workspaceInformation.elementAt(0),
        workspaceInformation.elementAt(1),
      )) {
        await logUserEntrance("r38711", workspaceInformation.elementAt(2));
        await incrementUserInWorkspace(_docRef);
        ApplicationPreferences()
            .saveEnteredWorkspaceNameAsSharedPreference(_docRef.id);
      } else
        setUserAccessStatus(UserAccessStatus.Denied);
    } catch (exception) {
      setDatabaseErrorStatus(DatabaseErrorStatus.Exception, exception);
    }
  }

  Future<void> leaveWorkspace() async {
    //! Exchange "" with var id.
    var _docRef = getDocReference("");

    try {
      var timestamp =
          await ApplicationPreferences().getEntryTimestampOfSharedPreferences();

      await logUserExit(timestamp, _docRef);
    } catch (exception) {
      setDatabaseErrorStatus(DatabaseErrorStatus.Exception, exception);
    }
  }

  setUserAccessStatus(UserAccessStatus status) {
    _userAccessStatus = status;
    notifyListeners();
  }

  Future<void> logUserEntrance(String studentId, String workspaceName) async {
    CollectionReference _collRef = FirebaseFirestore.instance.collection(_LOG);

    // ignore: non_constant_identifier_names
    var NOW = DateTime.now();
    // ignore: non_constant_identifier_names
    var YEAR_MONTH_DAY_HOUR24_MINUTE =
        DateFormat('yyyyy.MMMMM.dd HH:mm').format(NOW);
    // ignore: non_constant_identifier_names
    var YEAR_NUM_MONTH_DAY = DateFormat.yMd().format(NOW);
    // ignore: non_constant_identifier_names
    var HOUR24_MINUTE = DateFormat.Hm().format(NOW);

    try {
      _collRef.doc(YEAR_MONTH_DAY_HOUR24_MINUTE).set(
        {
          "date:": YEAR_NUM_MONTH_DAY,
          "enter": HOUR24_MINUTE,
          "leave": "",
          "studentId": studentId,
          "workspaceName": workspaceName,
        },
      );
      ApplicationPreferences()
          .saveEntryTimestampAsSharedPreference(YEAR_MONTH_DAY_HOUR24_MINUTE);
    } catch (exception) {
      setDatabaseErrorStatus(DatabaseErrorStatus.Exception, exception);
    }
  }

  Future<void> logUserExit(String timestamp, DocumentReference docRef) async {
    CollectionReference _collRef = FirebaseFirestore.instance.collection(_LOG);

    // ignore: non_constant_identifier_names
    var NOW = DateTime.now();
    // ignore: non_constant_identifier_names
    var HOUR24_MINUTE = DateFormat.Hm().format(NOW);

    try {
      _collRef.doc(timestamp).update(
        {
          "leave": HOUR24_MINUTE,
        },
      );
      decrementUserInWorkspace(docRef);
    } catch (exception) {
      setDatabaseErrorStatus(DatabaseErrorStatus.Exception, exception);
    }
  }

  /// Returns a document reference based on the [id].
  DocumentReference getDocReference(String id) {
    DocumentReference _docRef = FirebaseFirestore.instance
        .collection(_WORKSPACE)
        //! Id string only for development. Remove and replace by [docId].
        .doc("9kU3kD1Bs9JlHmVbGtQu");

    return _docRef;
  }

  /// Returns the current, the max allowed users and the name of a workspace as iterable.
  ///
  /// Throws an [Exception] if the document snapshot could not be initialized.
  Future<Iterable> getWorkspaceInformation(DocumentReference docRef) async {
    try {
      DocumentSnapshot snapshot = await docRef.get();

      return [
        snapshot["currentInWorkspace"],
        snapshot["maxInWorkspace"],
        snapshot["name"]
      ];
    } catch (exception) {
      setDatabaseErrorStatus(DatabaseErrorStatus.Exception, exception);
      return null;
    }
  }

  bool checkUserCountInWorkspace(int current, int max) {
    if (current < max)
      return true;
    else
      return false;
  }

  /// Increments the current user in workspace by +1.
  ///
  /// Throws an [Exception] if the update could not be conducted.
  Future<void> incrementUserInWorkspace(DocumentReference docRef) async {
    try {
      await docRef.update(
        {"currentInWorkspace": FieldValue.increment(1)},
      );
    } catch (exception) {
      setDatabaseErrorStatus(DatabaseErrorStatus.Exception, exception);
    }
  }

  /// Decrements the current user in a workspace by -1.
  ///
  /// Throws an [Exception] if the update could not be conducted.
  Future<void> decrementUserInWorkspace(DocumentReference docRef) async {
    try {
      await docRef.update(
        {"currentInWorkspace": FieldValue.increment(-1)},
      );
    } catch (exception) {
      setDatabaseErrorStatus(DatabaseErrorStatus.Exception, exception);
    }
  }

  setDatabaseErrorStatus(DatabaseErrorStatus status, String exception) {
    dbException = exception;
    _errorStatus = status;
    notifyListeners();
  }
}
