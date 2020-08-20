import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';




class HelperFunction extends ChangeNotifier{
  static String sharedPreferencesLoggedInKey='IsLoggedIn';
  static String sharedPreferencesUserNameKey='UserNameKey';
  static String sharedPreferencesUserEmailKey='UserEmailKey';



  Future<bool> saveUserLoggedInStatus (String isUserLoggedIn) async{

    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    print(isUserLoggedIn);
    notifyListeners();

    return await sharedPreferences.setString(sharedPreferencesLoggedInKey, isUserLoggedIn);

  }
   Future<bool> saveUserNameSharedPreference (String userName) async{


    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    print(userName);
    notifyListeners();

    return await sharedPreferences.setString(sharedPreferencesUserNameKey, userName);

  }
   Future<bool> saveUserEmailSharedPreference (String userEmail) async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    print(userEmail);
    notifyListeners();

    return await sharedPreferences.setString(sharedPreferencesUserEmailKey, userEmail);

  }

   Future<String> getUserLoggedInStatus () async{

    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    notifyListeners();

    return sharedPreferences.getString(sharedPreferencesLoggedInKey);

  }
   Future<String> getUserNameSharedPreference () async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    notifyListeners();

    return sharedPreferences.getString(sharedPreferencesUserNameKey);

  }
   Future<String> getUserEmailSharedPreference () async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    notifyListeners();

    return sharedPreferences.getString(sharedPreferencesUserEmailKey);

  }

}