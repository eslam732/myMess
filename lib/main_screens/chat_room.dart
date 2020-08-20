import 'package:flutter/material.dart';
import 'package:messenger_app/constants.dart';
import 'package:messenger_app/helper/helperFunction.dart';
import 'package:messenger_app/services/authentication.dart';


class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods _authMethods=AuthMethods();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      getUSerInfo();
    });

    super.initState();
  }
  getUSerInfo() async{

      MyInfo.myName= await HelperFunction().getUserNameSharedPreference();
      print('my info name is ${MyInfo.myName}');
      MyInfo.meEmail=await HelperFunction().getUserEmailSharedPreference();
      print('my info name is ${MyInfo.myName}');




  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight=MediaQuery.of( context).size.height;
    double deviceWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
        actions: [
          GestureDetector(
            onTap: (){
              _authMethods.signOut();
              Navigator.pushReplacementNamed(context, 'SignIn');
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal:deviceWidth*.05,vertical: deviceHeight*.008 ),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed:(){ Navigator.pushNamed(context, 'SearchScreen');},
        ),
      body: Container(),
    );
  }
}
