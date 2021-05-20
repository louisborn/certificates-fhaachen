import 'package:shared_preferences/shared_preferences.dart';

/// A global [SharedPreferences] instance.
///
late SharedPreferences prefs;

/// A service to persist key values.
///
class ApplicationPreferences {
  /// Returns the enter [timestamp] into a workspace.
  ///
  /// ignore: await_only_futures
  Future<String?> get timestamp async => await prefs.getString('timestamp');

  /// Returns the entered [workspace] name.
  ///
  /// ignore: await_only_futures
  Future<String?> get workspace async => await prefs.getString('workspace')!;

  /// Returns the current logged in [student].
  ///
  /// ignore: await_only_futures
  Future<String?> get student async => await prefs.getString('studentId')!;

  bool saveStudentAsSharedPreference(String studentId) {
    try {
      prefs.setString('studentId', studentId);
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  bool saveEntryTimestampAsSharedPreference(String timestamp) {
    try {
      prefs.setString('timestamp', timestamp);
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  bool saveEnteredWorkspaceNameAsSharedPreference(String workspace) {
    try {
      prefs.setString('workspace', workspace);
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }
}
