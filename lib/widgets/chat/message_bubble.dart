import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Key? key;
  final String? message;
  final String? userName;
  final bool? isMe;
  final String? userImage;

  MessageBubble(this.message, this.userName, this.isMe, this.userImage,
      {this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color:
                    isMe! ? Theme.of(context).primaryColor : Colors.grey[500],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomLeft: isMe! ? Radius.circular(20) : Radius.circular(0),
                  bottomRight: isMe! ? Radius.circular(0) : Radius.circular(20),
                ),
              ),
             width: 160,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: isMe! ? TextAlign.end : TextAlign.start,

                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 7.0),
                    child: Text(
                      message!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white,
                       ),
                      textAlign: isMe! ? TextAlign.start : TextAlign.end,

                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Positioned(
          child: CircleAvatar(
          backgroundImage: NetworkImage(userImage!),
        ),
        top: -5,
          right:isMe!? 130:null,
          left:!isMe!? 130:null,
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
