
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messenger_app/helper/helperFunction.dart';
import 'package:messenger_app/main_screens/chat_room.dart';
import 'package:messenger_app/main_screens/chat_screen.dart';
import 'package:messenger_app/main_screens/search.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'auth_pages/sign_in_page.dart';
import 'auth_pages/sign_up_page.dart';

void main() {


// ignore: invalid_use_of_visible_for_testing_member
//SharedPreferences.setMockInitialValues({});
runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (context)=>HelperFunction(),)
  ],
  child: MyApp()
));



}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String userLoggedInStatus='false';
  bool st=false;
  @override
  void initState() {
    print('init');
    // TODO: implement initState
    getLoggedInStatus();
    super.initState();
  }

  getLoggedInStatus() async{
    print('gettstate');

  userLoggedInStatus=await HelperFunction().getUserNameSharedPreference();


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:SignIn(),
      routes: {
    'SignIn':(context)=>SignIn(),
        'ChatRoom':(context)=>ChatRoom(),
        'SearchScreen':(context)=>SearchScreen(),
        'SignUp':(context)=>SignUp(),
        'ConversationScreen':(context)=>ConversationScreen()
    }
      ,
    );
  }
}

