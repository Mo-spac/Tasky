import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static final PreferenceManager _inistance = PreferenceManager._internal();

  // Factroy Constructor => return singlton instance
  factory PreferenceManager() {
    return _inistance;
  }

  // Private Constructor
  PreferenceManager._internal();

  late SharedPreferences _preference;

  init() async {
    _preference = await SharedPreferences.getInstance();
  }

  // get
  String? getString(String key) {
    return _preference.getString(key);
  }

  bool? getBool(String key) {
    return _preference.getBool(key);
  }

  int? getInt(String key) {
    return _preference.getInt(key);
  }

  double? getdouble(String key) {
    return _preference.getDouble(key);
  }

  List<String>? getStringList(String key) {
    return _preference.getStringList(key);
  }

  // set
  Future<bool> setString(String key, String value) async {
    return await _preference.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preference.setBool(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await _preference.setInt(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _preference.setDouble(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await _preference.setStringList(key, value);
  }

  // delete

  remove(String key) {
    return _preference.remove(key);
  }

  clear() {
    return _preference.clear();
  }
}
