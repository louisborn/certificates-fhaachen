import 'package:shared_preferences/shared_preferences.dart';

//* A shared preferences to save single key values.
//*
//*
class ApplicationPreferences {
  //* Saves a students id as a shared preference.
  Future<bool> saveStudentAsSharedPreference(String studentId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      prefs.setString('studentId', studentId);
      return true;
    } catch (exception) {
      print(exception.toString());
      return false;
    }
  }

  //* Saves a students entry timestamp in a workspace.
  Future<bool> saveEntryTimestampAsSharedPreference(String timestamp) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      prefs.setString('timestamp', timestamp);
      return true;
    } catch (exception) {
      print(exception.toString());
      return false;
    }
  }
}
