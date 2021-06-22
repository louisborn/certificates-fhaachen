import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services.dart';

/// Indicates the current usage status of a user.
///
enum UserUsageStatus {
  NotUsing,
  Using,
  Denied,
  Pending,
}

class UsageControlService extends ChangeNotifier {
  /// Getter and setter for the current error status.
  ///
  UserUsageStatus get userUsageStatus => _userUsageStatus;
  UserUsageStatus _userUsageStatus = UserUsageStatus.NotUsing;

  Future<DocumentSnapshot> getDocument(String path) async {
    DocumentSnapshot data =
        await Document<DocumentSnapshot>(path: path).getDocumentSnapshot();

    return data;
  }

  Future<void> checkUserAuthorization(List<dynamic> assignedTo) async {
    setUserAccessStatus(UserUsageStatus.Pending);
    for (int i = 0; i < assignedTo.length; i++) {
      if (assignedTo[i] == PreferenceService().getString('studentId')) {
        setUserAccessStatus(UserUsageStatus.Using);
        break;
      }
      setUserAccessStatus(UserUsageStatus.Denied);
    }
  }

  setUserAccessStatus(UserUsageStatus status) {
    _userUsageStatus = status;
    notifyListeners();
  }
}
