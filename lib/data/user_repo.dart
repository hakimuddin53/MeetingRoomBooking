import 'package:abx_booking/utils/preference.dart';

class UserRepo {
  static const String kUserName = "USER_NAME";
  static const String kUserPassword = "USER_PASSWORD";

  // User Name
  Future<void> setUserName(String info) {
    return Preference.setString(kUserName, info);
  }

  Future<String> getUserName() async {
    return Preference.getString(kUserName, def: "");
  }

  Future<void> reset() async {
    await Preference.remove(kUserName);
  }

  // User Login Password
  Future<void> setUserPassword(String password) {
    return Preference.setString(kUserPassword, password);
  }

  Future<String> getUserPassword() async {
    return Preference.getString(kUserPassword, def: "");
  }
}
