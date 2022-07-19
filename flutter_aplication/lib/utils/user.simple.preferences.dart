import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _keyUseremail = 'useremail';
  static const _keyUsersenha = 'usersenha';

  static Future init() async =>
    _preferences = await SharedPreferences.getInstance();

  static Future setUseremail(String username) async =>
    await _preferences?.setString(_keyUseremail, username);

  static Future setUsersenha(String usersenha) async =>
  await _preferences?.setString(_keyUsersenha, usersenha);

  static String? getUsersenha() => _preferences?.getString(_keyUsersenha);
  static String? getUseremail() => _preferences?.getString(_keyUseremail);

}