import 'dart:async';

import 'package:certificates/models.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services.dart';

/// Indicates the current access status of a user.
///
enum UserAccessStatus {
  NotEntered,
  Entered,
  Left,
  Denied,
  Pending,
}

/// Indicates how to handle transaction errors.
///
enum AccessControlError {
  NoError,
  Exception,
}

/// A service to provide a access control system for workspaces.
///
/// The service consists of an [enterWorkspace] and a [leaveWorkspace]
/// function.
///
/// The [enterWorkspace] includes a [checkUserCountInWorkspace] and
/// denies an access if the current number of users > max allowed users.
/// If an  access is granted to a user [logUserEntrance] is called.
///
/// The [leaveWorkspace] includes a [logUserExit] to update the leave
/// time in the log.
///
/// [setAccessControlError] is used to output any exception occurring
/// during transactions.
///
class AccessControlService extends ChangeNotifier {
  /// A text containing the current exception that occurred.
  ///
  late String _exception;

  /// The collection name for the workspaces.
  static const String collection_workspace = "workspaces";

  /// The collection name for the logs.
  static const String collection_log = "log";

  /// The instance for the shared preferences service.
  final sharedPreferenceService = PreferenceService();

  /// Returns any [_exception] message occurred during transaction.
  ///
  String get accessControlException => _exception;

  /// Getter and setter for the current error status.
  ///
  AccessControlError get accessControlError => _accessControlError;
  AccessControlError _accessControlError = AccessControlError.NoError;

  /// Getter and setter for the current user access status.
  ///
  UserAccessStatus get userAccessStatus => _userAccessStatus;
  UserAccessStatus _userAccessStatus = UserAccessStatus.NotEntered;

  Future<void> enterWorkspace(String path, Workspace workspace) async {
    setUserAccessStatus(UserAccessStatus.Pending);
    var _docRef = getDocReference(path);
    try {
      if (workspace.currentInWorkspace! < workspace.maxInWorkspace!) {
        await logUserEntrance(
            PreferenceService().getString('studentId')!, workspace.name!);
        await incrementUserInWorkspace(_docRef);
        setUserAccessStatus(UserAccessStatus.Entered);
      } else
        setUserAccessStatus(UserAccessStatus.Denied);
    } catch (exception) {
      catchAnyException(
        AccessControlError.Exception,
        exception.toString(),
      );
      throw Exception("Failed to enter workspace");
    }
  }

  Future<void> leaveWorkspace(String path) async {
    setUserAccessStatus(UserAccessStatus.Pending);
    var _docRef = getDocReference(path);
    try {
      var timestamp = await sharedPreferenceService.getString('timestamp');

      await logUserExit(timestamp!, _docRef);
      setUserAccessStatus(UserAccessStatus.NotEntered);
    } catch (exception) {
      catchAnyException(
        AccessControlError.Exception,
        exception.toString(),
      );
      setUserAccessStatus(UserAccessStatus.Entered);
      throw Exception("Failed to leave workspace");
    }
  }

  setUserAccessStatus(UserAccessStatus status) {
    _userAccessStatus = status;
    notifyListeners();
  }

  Future<void> logUserEntrance(String studentId, String workspaceName) async {
    CollectionReference _collRef =
        FirebaseFirestore.instance.collection(collection_log);

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
          "date": YEAR_NUM_MONTH_DAY,
          "enter": HOUR24_MINUTE,
          "leave": "",
          "studentId": studentId,
          "workspaceName": workspaceName,
        },
      );
      sharedPreferenceService.putString(
          'timestamp', YEAR_MONTH_DAY_HOUR24_MINUTE);
    } catch (exception) {
      catchAnyException(
        AccessControlError.Exception,
        exception.toString(),
      );
      throw Exception("Failed to log user entrance");
    }
  }

  Future<void> logUserExit(String timestamp, DocumentReference docRef) async {
    CollectionReference _collRef =
        FirebaseFirestore.instance.collection(collection_log);

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
      catchAnyException(
        AccessControlError.Exception,
        exception.toString(),
      );
      throw Exception("Failed to log user exit");
    }
  }

  DocumentReference getDocReference(String id) {
    DocumentReference _docRef = FirebaseFirestore.instance.doc(id);

    return _docRef;
  }

  Future<Iterable> getDocument(DocumentReference docRef) async {
    try {
      DocumentSnapshot snapshot = await docRef.get();

      return [
        snapshot["currentInWorkspace"],
        snapshot["maxInWorkspace"],
        snapshot["name"]
      ];
    } catch (exception) {
      catchAnyException(
        AccessControlError.Exception,
        exception.toString(),
      );
      throw Exception("Failed to get workspace information");
    }
  }

  bool checkUserCountInWorkspace(int current, int max) {
    if (current < max)
      return true;
    else
      return false;
  }

  Future<void> incrementUserInWorkspace(DocumentReference docRef) async {
    try {
      await docRef.update(
        {"currentInWorkspace": FieldValue.increment(1)},
      );
    } catch (exception) {
      catchAnyException(
        AccessControlError.Exception,
        exception.toString(),
      );
      throw Exception("Failed to increment");
    }
  }

  Future<void> decrementUserInWorkspace(DocumentReference docRef) async {
    try {
      await docRef.update(
        {"currentInWorkspace": FieldValue.increment(-1)},
      );
    } catch (exception) {
      catchAnyException(
        AccessControlError.Exception,
        exception.toString(),
      );
      throw Exception("Failed to decrement");
    }
  }

  void catchAnyException(AccessControlError error, String exception) {
    this._exception = exception;
    _accessControlError = error;
    notifyListeners();
  }
}
