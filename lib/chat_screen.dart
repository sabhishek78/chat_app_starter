import 'package:chat_app_starter/chat_bubble.dart';
import 'package:flutter/cupertino.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Widget> chatWidgets = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() => setState(() {}));
    getMessagesStream();
  }

  String currentUserEmail = '';

  void getMessages() async {
    QuerySnapshot collectionData =
        await Firestore.instance.collection('messages').getDocuments();
    chatWidgets.clear();
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    currentUserEmail = currentUser.email;
    for (DocumentSnapshot message in collectionData.documents) {
      String text = message.data['text'];
      String sender = message.data['sender'];
      chatWidgets.add(ChatBubble(
        text: text,
        sender: sender,
        isUser: sender == currentUserEmail,
      ));
    }
    setState(() {});
  }

  void getMessagesStream() async {
    chatWidgets.clear();
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    currentUserEmail = currentUser.email;
    await for (var snapshot
        in Firestore.instance.collection('messages').snapshots()) {
      for (var message in snapshot.documents) {
        String text = message.data['text'];
        String sender = message.data['sender'];
        chatWidgets.add(ChatBubble(
          text: text,
          sender: sender,
          isUser: sender == currentUserEmail,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'McLaren Chat',
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontFamily: 'OldLondon',
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            IconButton(
              icon: Icon(Icons.cloud_download),
              onPressed: getMessages,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: chatWidgets,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                    ),
                    color: Colors.blue,
                    onPressed: controller.text.isEmpty ? null : sendMessage,
                  )
                ],
              )
            ],
          ),
        ));
  }

  void sendMessage() async {
    await Firestore.instance.collection('messages').add(
        {'sender': 'abhishekshrivastava78@gmail.com', 'text': controller.text});
    controller.clear();
    print("Message sent");
  }
}
