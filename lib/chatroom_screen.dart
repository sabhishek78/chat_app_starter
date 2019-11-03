
import 'package:flutter/material.dart';


class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              child: Text(
                'Create Chat room',
                style: TextStyle(color: Colors.white, fontSize: 21),
              ),
              color: Colors.blue,
              onPressed: () {Navigator.pushReplacementNamed(context, 'chat');},
            ),
            SizedBox(height: 10,),
            RaisedButton(
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              child: Text(
                'Join Chat room',
                style: TextStyle(color: Colors.white, fontSize: 21),
              ),
              color: Colors.blue,
              onPressed: () {Navigator.pushReplacementNamed(context, 'chatroomlist');},
            ),
          ],

        ),
      ),


      );

  }
}
