import 'package:shared_preferences/shared_preferences.dart';

/// A base class for the shared preference service.
///
abstract class BaseSharedPreferences {
  /// Returns a shared preference instance.
  Future<void> getInstance();

  /// Deletes a saved key.
  Future<void> deletePrefs();

  /// Saves the user [id] as shared preference key.
  Future<bool> saveUserId(String id);

  /// Saves the enter [timestamp] of a user into a
  /// workspace as shared preference key.
  ///
  bool saveEntranceTimestamp(String timestamp);

  /// Saves the workspace [id] as shared preference key.
  bool saveWorkspaceId(String id);
}

/// A service to persist key values.
///
class ApplicationPreferences implements BaseSharedPreferences {
  /// Returns a single instance of this class.
  ///
  factory ApplicationPreferences() {
    return _instance;
  }

  ApplicationPreferences._internal();

  /// A singleton instance of the [ApplicationPreferences].
  static final ApplicationPreferences _instance =
      ApplicationPreferences._internal();

  /// A global [SharedPreferences] instance.
  ///
  late SharedPreferences _prefInstance;

  /// Returns the enter [timestamp] into a workspace.
  ///
  Future<String?> get timestamp async =>

      /// ignore: await_only_futures
      await _prefInstance.getString('timestamp');

  /// Returns the entered [workspace] name.
  ///
  Future<String?> get workspace async =>

      /// ignore: await_only_futures
      await _prefInstance.getString('workspace')!;

  /// Returns the current logged in [student].
  ///
  Future<String?> get student async =>

      /// ignore: await_only_futures
      await _prefInstance.getString('studentId')!;

  @override
  Future<void> getInstance() async {
    this._prefInstance = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> deletePrefs() async {
    try {
      _prefInstance.clear();
      return true;
    } catch (exception) {
      throw Exception(exception.toString());
    }
  }

  @override
  Future<bool> saveUserId(String studentId) async {
    try {
      await _prefInstance.setString('studentId', studentId);
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  @override
  bool saveEntranceTimestamp(String timestamp) {
    try {
      _prefInstance.setString('timestamp', timestamp);
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  @override
  bool saveWorkspaceId(String workspace) {
    try {
      _prefInstance.setString('workspace', workspace);
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }
}
