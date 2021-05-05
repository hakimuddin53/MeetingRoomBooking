// import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:package_info/package_info.dart';

class Common {
  // Future<String> getDeviceIdentifier(BuildContext context) async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   if (Theme.of(context).platform == TargetPlatform.iOS) {
  //     IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
  //     return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  //   } else {
  //     AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
  //     return androidDeviceInfo.androidId; // unique ID on Android
  //   }
  // }

  static void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  // static String formatCurrency(double amount) {
  //   final formatter = NumberFormat('#,###');
  //   return formatter.format(amount.toDouble()).toString();
  // }
  //
  // Future<String> getAppVersionName() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //
  //   return packageInfo.version.toString();
  // }
}
