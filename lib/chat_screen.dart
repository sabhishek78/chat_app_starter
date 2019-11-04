import 'package:chat_app_starter/chat_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
String currentUserEmail='';
class ChatScreen extends StatefulWidget {
  final String chatroomId;
  ChatScreen({this.chatroomId});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  //List<Widget> chatWidgets = [];
 TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() => setState(() {}));
    getUser();
    //currentUserEmail=FirebaseAuth.instance.currentUser().toString();

  }
 void getUser()async{
   FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
   currentUserEmail = currentUser.email;
 }




 /* void getMessagesStream() async {

    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    currentUserEmail = currentUser.email;
    await for (var snapshot
        in Firestore.instance.collection('McLarenChat').snapshots()) {
      chatWidgets.clear();
      for (var message in snapshot.documents) {
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
  }*/
String currentUserEmail='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'chatroom ${widget.chatroomId}',
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
        body:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: Firestore.instance.collection('chatrooms').document(widget.chatroomId).collection('messages').snapshots(),
                    builder: (context,snapshot){
                      if(!snapshot.hasData){
                        return CircularProgressIndicator();

                      }
                      return ListView.builder(itemBuilder: (context, index) {
                          return ChatBubble(
                            text: snapshot.data.documents[index].data['text'],
                            sender:  snapshot.data.documents[index].data['sender'],

                            isUser: snapshot.data.documents[index].data['sender'] ==currentUserEmail,
                          );
                        },itemCount: snapshot.data.documents.length,shrinkWrap: true,
                      );
                    },
                  )




                 // SingleChildScrollView(
                 //   child: Column(
                 //     mainAxisSize: MainAxisSize.min,
                //      children: chatWidgets,
                 //   ),
               //   ),
                )


              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: controller,
                          maxLines: 1,
                          textAlign: TextAlign.left,

                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                      ),
                      color: Colors.blue,
                      onPressed: controller.text.isEmpty ? null :sendmessage,


                    )
                  ],
                ),
              )
            ],
          ),
        );

  }

  Future sendmessage() async {

    await Firestore.instance.collection('chatrooms').document(widget.chatroomId).collection('messages').add({'sender': currentUserEmail,

      'text':controller.text,
    });
    controller.clear();
  }


}
