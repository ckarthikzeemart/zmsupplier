import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/**
 * Created by RajPrudhviMarella on 11/Feb/2021.
 */

class Constants {
  // Strings
  static const String app_name = "Zeemart Supplier";
  static const String txt_change_password = "Change Password";
  static const String txt_help = "Help";
  static const String txt_ask_zeemart = "Ask Zeemart";
  static const String txt_send_feed_back = "Send FeedBack";
  static const String txt_terms_of_use = "Terms Of Use";
  static const String txt_privacy_policy = "Privacy policy";
  static const String txt_log_out = "Sign Out";
  static const String txt_support = "Support";
  static const String txt_account = "Account";

  static const String termsUrl = "https://www.zeemart.asia/terms";
  static const String privacyUrl = "https://www.zeemart.asia/privacy-policy";
  static const String loginInfo = "loginInfo";
}

class SharedPref {
  saveData(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }
}
