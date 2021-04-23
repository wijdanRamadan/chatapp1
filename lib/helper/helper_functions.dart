import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions
{
static String sharedPreferenceUserLoggedInKey= "ISLOGGEDIN";
static String sharedPreferenceUserNameKey= "USERNAMEKEY";
static String sharedPreferenceUserEmailKey= "USEREMAILKEY";
static String sharedPreferenceUserIdKey= "USERIDKEY";

static Future<void> saveUserLoggedInsharedPreference(bool isLoggedIn) async
{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool(sharedPreferenceUserLoggedInKey, isLoggedIn);
}

static Future<bool> getUserLoggedInsharedPreference() async
{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.getBool(sharedPreferenceUserLoggedInKey);
}

static Future<void> saveUserNamesharedPreference(String username) async
{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString(sharedPreferenceUserNameKey, username);
}

static Future<String> getUserNamesharedPreference() async
{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.getString(sharedPreferenceUserNameKey);
}


static Future<void> saveUserEmailsharedPreference(String userEmail) async
{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString(sharedPreferenceUserEmailKey, userEmail);
}

static Future<String> getUserEmailsharedPreference() async
{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.getString(sharedPreferenceUserEmailKey);
}

static Future<void> saveUserIdsharedPreference(String userId) async
{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString(sharedPreferenceUserIdKey, userId);
}

static Future<String> getUserIdsharedPreference(String userId) async
{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.getString(sharedPreferenceUserIdKey);
}

getConversationId(String email1 , String email2)
{
  if (email1.substring(0, 1).codeUnitAt(0) > email2.substring(0, 1).codeUnitAt(0))
  return "$email2\_$email1";
  else
    return
      "$email1\_$email2";


}
}