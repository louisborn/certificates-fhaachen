/// A base class for the shared preference service.
///
abstract class BaseSharedPreferences {
  /// Returns a shared preference instance.
  Future<void> getInstance();

  /// Saves the user [id] as shared preference key.
  bool saveUserId(String id);

  /// Saves the enter [timestamp] of a user into a
  /// workspace as shared preference key.
  ///
  bool saveEntranceTimestamp(String timestamp);

  /// Saves the workspace [id] as shared preference key.
  bool saveWorkspaceId(String id);
}
