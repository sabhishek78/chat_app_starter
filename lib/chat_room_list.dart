import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRoomList extends StatefulWidget {
  @override
  _ChatRoomListState createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Chat room List',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'OldLondon',
          ),
        ),
        actions: <Widget>[

          /* IconButton(
              icon: Icon(Icons.cloud_download),
              onPressed: getMessagesStream,
            ), */
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Column(


      ),
    );
  }
}