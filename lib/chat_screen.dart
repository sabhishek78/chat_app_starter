import 'main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Widget> chatWidgets=[];
  TextEditingController controller=TextEditingController();
  
  @override
  void initState(){
    super.initState();
    controller.addListener(()=> setState((){}));
  }
  void getMessages() async{
    QuerySnapshot collectionData=await Firestore.instance.collection('messages').getDocuments();
    chatWidgets.clear();
    for(DocumentSnapshot message in collectionData.documents){
      String text=message.data['text'];
      String sender=message.data['sender'];
      chatWidgets.add(Text('$text by $sender'));
    }
    chatWidgets.add(Expanded(child:Container()));
    chatWidgets.add(Row());
    setState(() {

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,

        title: Text(
          'Chat',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontFamily: 'OldLondon',
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon:Icon(Icons.exit_to_app),
          onPressed: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context,'/');

          },
          ),

          IconButton(
            icon:Icon(Icons.cloud_download),
            onPressed: getMessages,

          ),
        ],

      ),
      body:Row(
        children: <Widget>[
          TextField(
            textAlign: TextAlign.center,
            maxLines: 1,
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'spacexRocks',
                border: OutlineInputBorder()),
          ),
          SizedBox(width: 5,),
          RaisedButton(
            padding: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            child: Text(
              'Send',
              style: TextStyle(color: Colors.white, fontSize: 21),
            ),
            color: Colors.blue,
            onPressed:
              controller.text.isEmpty? null: sendMessage,



          ),
        ],
      )
    );
  }

  void sendMessage() async{

   await Firestore.instance.collection('messages').add({'sender':'abhishekshrivastava78@gmail.com',
      'text':controller.text});
   controller.clear();
  }
}
