import 'package:shared_preferences/shared_preferences.dart';

/// A service to persist key values.
///
class PreferenceService {
  /// Returns a single instance of this class.
  ///
  factory PreferenceService() {
    return _instance;
  }

  PreferenceService._internal();

  /// A singleton instance of the [PreferenceService].
  static final PreferenceService _instance = PreferenceService._internal();

  /// A global [SharedPreferences] instance.
  ///
  late SharedPreferences _prefInstance;

  Future<void> getInstance() async {
    this._prefInstance = await SharedPreferences.getInstance();
  }

  String? getString(String key, {String defValue = ''}) {
    if (!_prefInstance.containsKey(key)) return defValue;
    return _prefInstance.getString(key);
  }

  Future<bool> putString(String key, String value) {
    return _prefInstance.setString(key, value);
  }

  Future<bool> clearAll() async {
    return await _prefInstance.clear();
  }
}
