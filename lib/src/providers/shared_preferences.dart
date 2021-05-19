import 'package:shared_preferences/shared_preferences.dart';

/// A service to persist key values.
///
class ApplicationPreferences {
  /// A [SharedPreferences] instance.
  ///
  late SharedPreferences prefs;

  Future<void> getSharedPreferencesInstance() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  /// Returns the enter [timestamp] into a workspace.
  ///
  String? get timestamp => prefs.getString('timestamp')!;

  /// Returns the entered [workspace] name.
  String? get workspace => prefs.getString('workspace')!;

  /// Returns the current logged in [student].
  ///
  String? get student => prefs.getString('studentId')!;

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
