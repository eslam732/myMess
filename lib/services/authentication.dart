import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:auth/auth.dart';

import 'dart:async';
import 'dart:io';


import 'package:http/http.dart' as http;

final FirebaseAuth _auth=FirebaseAuth.instance;
User _userFromFirebaseUser(FirebaseUser user){
  return user !=null? User(userId: user.uid) : null;
}

class AuthMethods {



 Future signIn({String email, String password}) async{
   try{
     AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
     FirebaseUser firebaseUser=result.user;
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('userEmail', email);
     
     return _userFromFirebaseUser(firebaseUser);
   }catch(error){

   }
 }

 Future signUp({String email,String password}) async{
   try{
     AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
     FirebaseUser firebaseUser=result.user;
     return _userFromFirebaseUser(firebaseUser);
   }catch(error){

   }
 }

 Future resetPass(String email) async{
   try{
     _auth.sendPasswordResetEmail(email: email);
   }catch(error){

   }
 }
 Future signOut ()async{
   try{
     _auth.signOut();
   }catch(error){

   }
 }
}