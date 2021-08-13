import 'dart:io';

import 'package:chat_app/widgets/auth/Auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class auth_screen extends StatefulWidget {


  @override
  _auth_screenState createState() => _auth_screenState();
}

class _auth_screenState extends State<auth_screen> {
  final _auth = FirebaseAuth.instance;
  bool _isloading = false;


  void _submitauth(String email, String password, String username, File image,
      bool isLogin, BuildContext ctx) async {
    if (this.mounted) {
      setState(() {});
    }
    UserCredential authtrsult;
    try {
      setState(() {
        _isloading = true;
      });
      if (isLogin) {
        authtrsult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authtrsult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image ')
            .child("${authtrsult.user!.uid + '.jpg'}");

        await ref.putFile(image);
        final url = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection("users")
            .doc(authtrsult.user!.uid)
            .set({
          "username": username,
          "password": password,
          "image_url": url,
        });
      }
    } on FirebaseAuthException catch (e) {
      String message = "Error Ocurred";
      if (e.code == 'weak-password') {
        message = ('The password provided is too weak.');
      } else if (e.code == 'user-not-found') {
        message = ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        message = ('Wrong password .');
      } else if (e.code == 'email-already-in-use') {
        message = ('The account is Not valid.');
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Theme.of(ctx).primaryColor,
          behavior: SnackBarBehavior.floating,


        ),
      );
      setState(() {
        _isloading = false;
      });
    } catch (e) {
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Auth_form(_submitauth, _isloading),
            );
  }
}
