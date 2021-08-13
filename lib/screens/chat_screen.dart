import 'package:chat_app/widgets/chat/message.dart';
 import 'package:chat_app/widgets/chat/new_message.dart';
 import 'package:firebase_auth/firebase_auth.dart';
 import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class chatScreen extends StatefulWidget {
  @override
  _chatScreenState createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print(message);
    });

  }
      @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHATAK"),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app, color: Colors.black),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Logout")
                  ],
                ),
                value: "logout",
              ),
            ],
            onChanged: (identyfier) {
              if (identyfier == "logout") FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: Container(
        child: Column(children: [
          Expanded(child: Message()),
          New_Message(),
        ]),
      ),
    );
  }
}
