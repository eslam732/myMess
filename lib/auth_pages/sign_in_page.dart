import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/material.dart';
import 'package:messenger_app/constants.dart';
import 'package:messenger_app/helper/helperFunction.dart';
import 'package:messenger_app/services/authentication.dart';
import 'package:messenger_app/services/database.dart';
import 'package:provider/provider.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthMethods _authMethods = AuthMethods();
  DatabaseMethods _databaseMethods=DatabaseMethods();
  TextEditingController emailTEController = TextEditingController();
  TextEditingController passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool  isLoading = false;
  QuerySnapshot _querySnapshotUSerInfo;


  @override
  Widget build(BuildContext context) {
    HelperFunction _helperFunction=Provider.of<HelperFunction>(context);

    double deviceHeight=MediaQuery.of(context).size.height;
   double deviceWidth=MediaQuery.of(context).size.width;

    signIn(){
      if (_formKey.currentState.validate()) {
        // HelperFunction.saveUserEmailSharedPreference(emailTEController.text);
        _helperFunction.saveUserLoggedInStatus('true');
    _helperFunction.saveUserEmailSharedPreference(emailTEController.text);
      //  print(_helperFunction.getUserEmailSharedPreference());
       _databaseMethods.getUserByUserEmail(MyInfo.meEmail).then((value){

       });
        _databaseMethods.getUserByUserEmail(emailTEController.text).then((value){
          _querySnapshotUSerInfo=value;
         _helperFunction.saveUserNameSharedPreference(_querySnapshotUSerInfo.documents[0]['name']);
      print('user name is ******** ${_querySnapshotUSerInfo.documents[0]['name']}');

        });
        setState(() {
          isLoading = true;
        });

        _authMethods.signIn(email: emailTEController.text,password: passwordTEController.text).then((value){
          if(value!=null){
            _databaseMethods.getUserByUserEmail(emailTEController.text);

            Navigator.pushReplacementNamed(context, 'ChatRoom');
          }
        });



      }
    }

    return Scaffold(
     backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Sign In Page'),
      ),
      body:SingleChildScrollView(
        child:

      Container(
        padding: EdgeInsets.only(left: deviceWidth*.04,right: deviceWidth*.04,top: deviceHeight*.3),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailTEController,
                decoration:_inputDecoration('Email'),
                style: TextStyle(color: Colors.white),
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty ||
                      !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                          .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                },
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                style: TextStyle(color: Colors.white),
                // ignore: missing_return
                validator: (String value) {
                  if (value.length < 6) {
                    return 'Password should be greater than 6 digits';
                  }
                },
                controller: passwordTEController,
                decoration: _inputDecoration('Password'),
                obscureText: true,
              ),
              SizedBox(height: 5.0,),

              GestureDetector(
                child: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.transparent,

                  child: Text('Forgot Password',style: TextStyle(color: Colors.white),),
                ),
              ),
              GestureDetector(
                onTap: (){
                  signIn();
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: deviceHeight*.03),
                  width: deviceWidth*.8,
                  height: deviceHeight*.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0)
                        ,color: Colors.grey
                  ),
                  child: Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 20),),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: deviceHeight*.03),
                width: deviceWidth*.8,
                height: deviceHeight*.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0)
                    ,color: Colors.white
                ),
                child: Text('Sign in with Google',style: TextStyle(color: Colors.black,fontSize: 18),),

              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Text('New To My App ?',style: TextStyle(color: Colors.white),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, 'SignUp');
                    },
                    child: Text('Register Now',style: TextStyle(color: Colors.white,decoration: TextDecoration.underline)),
                  )
                ],
              )

            ],
          ),
        ),
      ) ,

      ));
  }
}


InputDecoration _inputDecoration(String hintText){
  return  InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.white),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white54)
    ),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white54)
    ),


  );
}