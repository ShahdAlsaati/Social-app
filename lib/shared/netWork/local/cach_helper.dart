import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences sharedPrefernces;

  static init()async
  {
    sharedPrefernces= await SharedPreferences.getInstance();
  }
  static Future<bool> putBool({
    required String key,
    required bool value,
  })async
  {
    return await sharedPrefernces.setBool(key, value);
  }
  static dynamic getData ({
    required String ?key,
  })
  {
    return sharedPrefernces.get(key!);
  }
  static Future<bool> saveListData ({
    required String key,
    required List<String>value,
  })async{
    return  await sharedPrefernces.setStringList(key, value);
  }
  static Future<bool> saveData ({
    required String key,
    required dynamic value,
  }) async{
    if(value is String){
      return await sharedPrefernces.setString(key, value);
    }
    if(value is int){
      return await sharedPrefernces.setInt(key, value);
    }
    if(value is bool){
      return await sharedPrefernces.setBool(key, value);
    }
    else{
      return await sharedPrefernces.setDouble(key, value);
    }


  }
  static Future<bool> removeData({
    required String? key,
  })async{
    return await sharedPrefernces.remove(key!);

  }

}