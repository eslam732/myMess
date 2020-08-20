import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/constants.dart';
import 'package:messenger_app/services/database.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchEditingController = TextEditingController();
  DatabaseMethods _databaseMethods = DatabaseMethods();
  QuerySnapshot _nameSnapshot;
  QuerySnapshot _emailSnapshot;
  _initiateSearch() {
    _databaseMethods
        .getUserByUserName(_searchEditingController.text)
        .then((value) {
      setState(() {
        print(value.toString());
        _nameSnapshot = value;
      });
    });
  }
  createChatRoomAndStartConversation(String userName,int index){
    print('my search name is *****${MyInfo.myName}');
    print('my search name is *****${MyInfo.meEmail}');
   if(_nameSnapshot.documents[index].data["email"]!=MyInfo.meEmail){
     List<String> _users=[userName,MyInfo.myName];

     String chatRoomId = getChatRoomId(userName, MyInfo.myName);

     Map<String ,dynamic> chatRoomMap={
       'users':_users,
       'chatRoomId':chatRoomId
     };

     _databaseMethods.createChatRoom(chatRoomId: chatRoomId,chatRoomMap: chatRoomMap);
     Navigator.pushNamed(context, 'ConversationScreen');
   }else{
     //alert
     print('asdasd');
   }
   }
  Widget searchTitle( {String userName,String userEmail,int index}){
    return Container(
      padding: EdgeInsets.only(right:14,left: 14),
      child: Row(
        children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 11,),
              Text(userEmail, style: TextStyle(color: Colors.black)),

            ],
          ),
          Spacer(),
          FlatButton(
            onPressed: (){
              createChatRoomAndStartConversation(userName,index);
            },


            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(color: Colors.redAccent),
            ),
            child: Text(
              'Message',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  Widget searchList() {
    return _nameSnapshot != null
        ? ListView.builder(
            itemCount: _nameSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              print("ee");
              return Container(
                child: Column(
                  children: [
                    searchTitle(
                      userEmail: _nameSnapshot.documents[index].data["email"],
                      userName: _nameSnapshot.documents[index].data["name"],
                      index:index
                    ),
                    Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    )
                  ],
                ),
              );
            },
          )
        : Container();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Search For Users'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: deviceWidth * .05, vertical: deviceHeight * .02),
              color: Colors.pink,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _searchEditingController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search....',
                        hintStyle: TextStyle(color: Colors.grey)),
                  )),
                  GestureDetector(
                      onTap: () {
                        _initiateSearch();
                      },
                      child: Icon(Icons.search))
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20.0),
                height: 250.0,
                child: searchList())
          ],
        ),
      ),
    );
  }
}



getChatRoomId(String a,String b){

  if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }{
    return"$a\_$b";
  }
}
