import 'package:shared_preferences/shared_preferences.dart';

import '../../providers.dart';

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
  bool saveUserId(String studentId) {
    try {
      _prefInstance.setString('studentId', studentId);
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
