import 'package:flutter/material.dart';
import 'package:messenger_app/helper/helperFunction.dart';
import 'package:messenger_app/services/authentication.dart';
import 'package:messenger_app/services/database.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthMethods _authMethods = AuthMethods();
  TextEditingController userNameTEController = TextEditingController();
  TextEditingController emailTEController = TextEditingController();
  TextEditingController passwordTEController = TextEditingController();
  DatabaseMethods _databaseMethods = DatabaseMethods();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    HelperFunction _helperFunction=Provider.of<HelperFunction>(context);

    signUp() {
      if (_formKey.currentState.validate()) {
        setState(() {
          isLoading = true;
        });
        _authMethods
            .signUp(
                email: emailTEController.text,
                password: passwordTEController.text)
            .then((value) {
          Map<String, String> userMap = {
            'name': userNameTEController.text,
            'email': emailTEController.text,
          };
          _helperFunction.saveUserEmailSharedPreference(emailTEController.text);
          _helperFunction.saveUserNameSharedPreference(userNameTEController.text);

          _databaseMethods.uploadUserInfo(userMap);
          _helperFunction.saveUserLoggedInStatus('true');
          Navigator.pushReplacementNamed(context, 'ChatRoom');
        });


      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Sign Up Page'),
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(
                      left: deviceWidth * .04,
                      right: deviceWidth * .04,
                      top: deviceHeight * .3),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: _inputDecoration('UserName'),
                            controller: userNameTEController,
                            // ignore: missing_return
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter a name';
                              }
                            },
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: _inputDecoration('Email'),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailTEController,
                            // ignore: missing_return
                            validator: (String value) {
                              if (value.isEmpty ||
                                  !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: _inputDecoration('Password'),
                            obscureText: true,
                            controller: passwordTEController,
                            // ignore: missing_return
                            validator: (String value) {
                              if (value.length < 6) {
                                return 'Password should be greater than 6 digits';
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          signUp();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: deviceHeight * .03),
                          width: deviceWidth * .8,
                          height: deviceHeight * .06,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.grey),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: deviceHeight * .03),
                        width: deviceWidth * .8,
                        height: deviceHeight * .06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.white),
                        child: Text(
                          'Sign Up with Google',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, 'SignIn');
                            },
                            child: Text('Sign In Now',
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

InputDecoration _inputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.white),
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
  );
}
