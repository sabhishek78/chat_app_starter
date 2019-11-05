import 'package:chat_app_starter/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';


class JoinCreateChatRoomScreen extends StatefulWidget {
  @override
  _JoinCreateChatRoomScreenState createState() => _JoinCreateChatRoomScreenState();
}

class _JoinCreateChatRoomScreenState extends State<JoinCreateChatRoomScreen> {
  final CollectionReference chatroomRef = Firestore.instance.collection('chatrooms');
 String chatroomId=generate4DigitId();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10,),
            RaisedButton(
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              child: Text(
                'Create Chat room',
                style: TextStyle(color: Colors.white, fontSize: 21),
              ),
              color: Colors.blue,
             // onPressed: () {Navigator.pushReplacementNamed(context, 'chat');},
              onPressed: (){
                chatroomRef.document(chatroomId).setData({'timestamp':DateTime.now()});
              },
            ),
            SizedBox(height: 10,),

            Expanded(
                child:  Container(
                  color: Colors.lightBlueAccent,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection('chatrooms').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(10.0),
                          itemBuilder: (context, index) => ListTile(
                              leading: const Icon(Icons.chat),
                              title: Text('${snapshot.data.documents[index].documentID}')
                          ),

                          itemCount: snapshot.data.documents.length,
                        );
                      }
                    },
                  ),
                ),
            ),
            SizedBox(height: 10,),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter chatroom Id'
          ),
          keyboardType: TextInputType.number,
          maxLength: 4,
          onChanged: (text) {
            chatroomId = text;
          },
        ),
            RaisedButton(
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              child: Text(
                'Join Chat room',
                style: TextStyle(color: Colors.white, fontSize: 21),
              ),
              color: Colors.blue,
              onPressed: () {
                //Navigator.pushReplacementNamed(context, 'chat');
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => ChatScreen(chatroomId: chatroomId)));
              },
            ),


          ],

        ),
      ),


      );

  }
}
String generate4DigitId(){
  var rng = new Random();
  var code = rng.nextInt(9000) + 1000;
  print(code);
  return code.toString();

}