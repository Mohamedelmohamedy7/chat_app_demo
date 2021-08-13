import 'package:flutter/material.dart';

class splach_screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child:  Text("Loading...",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

      ),
    );
  }
}
