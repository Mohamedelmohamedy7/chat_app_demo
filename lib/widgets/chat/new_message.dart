import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class New_Message extends StatefulWidget {
  @override
  _New_MessageState createState() => _New_MessageState();
}

class _New_MessageState extends State<New_Message> {
  final _controller = TextEditingController();
  String _excesistmassage = "";

  _submit() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userdata = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection("chat").add({
      "text": _excesistmassage,
      "createdAt": Timestamp.now(),
      "username": userdata["username"],
      "userImage": userdata["image_url"],
      "userId": user.uid,
    });
    _controller.clear();
    setState(() {
      _excesistmassage="";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(child: TextField(
              style: TextStyle(
                color: Colors.black,
                height: 0.7
              ),
              autocorrect: true,
              enableSuggestions: false,
              textCapitalization: TextCapitalization.sentences,
              controller: _controller,

              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                  filled: true,
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  borderSide:BorderSide(color: Theme.of(context).primaryColor),
                ),
                hintText: "Sent a message ...",
                hintStyle: TextStyle(color:Theme.of(context).primaryColor)

              ),
              onChanged: (val) {
                setState(() {
                  _excesistmassage = val;
                });
              },
            ),),
          IconButton(
              color: Theme.of(context).primaryColor,
              onPressed: _excesistmassage.trim().isEmpty ? null : _submit,
              disabledColor: Colors.black,
              icon: Icon(
                Icons.send,
              ))
        ],
      ),
    );
  }
}
