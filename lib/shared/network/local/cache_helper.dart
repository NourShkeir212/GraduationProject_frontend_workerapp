import 'package:shared_preferences/shared_preferences.dart';

import '../../var/var.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required String? key,
    required bool? value,
  }) async
  {
    return await sharedPreferences!.setBool(key!, value!);
  }

  static dynamic getData({
    required String? key,
  }) {
    return sharedPreferences?.get(key!);
  }

  static Future<bool> saveData({
    required String? key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key!, value);
    if (value is int) return await sharedPreferences!.setInt(key!, value);
    if (value is bool) return await sharedPreferences!.setBool(key!, value);

    return await sharedPreferences!.setDouble(key!, value);
  }

  static Future<bool> updateData({required String? key,required dynamic value}) async {
    removeData(key: key);
    if (value is String) return await sharedPreferences!.setString(key!, value);
    if (value is int) return await sharedPreferences!.setInt(key!, value);
    if (value is bool) return await sharedPreferences!.setBool(key!, value);

    return await sharedPreferences!.setDouble(key!, value);
  }

  static Future<bool> removeData({
    required String? key,
  }) async
  {
    return await sharedPreferences!.remove(key!);
  }

   Future<String> getCachedLanguageCode() async {
    final cachedLanguageCode = sharedPreferences!.getString("LOCALE");
    if (cachedLanguageCode != null) {
      lang =cachedLanguageCode;
      return cachedLanguageCode;
    } else {
      lang = "en";
      return 'en';
    }
  }

  Future<void> cacheLanguageCode(String languageCode) async{
    sharedPreferences!.setString('LOCALE', languageCode);
  }



}