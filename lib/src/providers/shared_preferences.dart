import 'package:shared_preferences/shared_preferences.dart';

/// A shared preferences to save single key values of users.
///
///
class ApplicationPreferences {
  /// Saves a students id as a shared preference.
  Future<bool> saveStudentAsSharedPreference(String studentId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      prefs.setString('studentId', studentId);
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  /// Saves a students entry timestamp of a workspace.
  Future<bool> saveEntryTimestampAsSharedPreference(String timestamp) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      prefs.setString('timestamp', timestamp);
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  Future<String?> getEntryTimestampOfSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var timestamp = prefs.getString('timestamp');
      return timestamp;
    } catch (exception) {
      print(exception);
      throw Exception("Failed to get timestamp");
    }
  }

  /// Saves the name of the entered workspace.
  Future<bool> saveEnteredWorkspaceNameAsSharedPreference(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      prefs.setString('workspace', name);
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }
}
