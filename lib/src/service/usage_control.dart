import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services.dart';

class UsageControlProvider extends ChangeNotifier {
  Future<DocumentSnapshot> getDocument() async {
    DocumentSnapshot data = await Document<DocumentSnapshot>(
            path: 'certificates/ZPSnJh7Sc95xdeFQ6mQ4')
        .getDocumentSnapshot();

    return data;
  }

  Future<void> checkUserAuthorization() async {
    DocumentSnapshot data = await getDocument();

    List<String> assignedTo = data['assignedTo'];

    for (int i = 0; i < assignedTo.length; i++) {
      if (assignedTo[i] == "r38711")
        print("TRUE");
      else
        print("FALSE");
    }
  }
}
