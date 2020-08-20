import 'package:flutter/material.dart';
import 'package:messenger_app/helper/helperFunction.dart';

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
String _string='ess';
   getName() async{
    print('asdasd');

    _string=await HelperFunction().getUserNameSharedPreference();
  }
  @override
  void initState() {
    // TODO: implement initState
    getName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {



    return Container(
      child: Center(
        child: Text(_string,style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
