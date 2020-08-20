import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class DatabaseMethods{
  getUserByUserName(String userName) async{
   return await Firestore.instance.collection("users").where("name",isEqualTo: userName).getDocuments();
  }


  getUserByUserEmail(String userEmail) async{
    return await Firestore.instance.collection("users").where("email",isEqualTo: userEmail).getDocuments();
  }


  uploadUserInfo(userMap){
    Firestore.instance.collection('users').add(userMap);
  }

  createChatRoom({@required String chatRoomId,@required chatRoomMap}){
    Firestore.instance.collection("chatRoom").document(chatRoomId).setData(chatRoomMap).catchError((error){
      print(error);
    });
  }
}
