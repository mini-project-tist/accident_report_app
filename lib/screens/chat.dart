import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class Chat extends StatefulWidget {
  static const String id = 'chat';
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  // final _auth = FirebaseAuth.instance;
  //
  // void getCurrentUser () async{
  //   final user = _auth.currentUser;
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff393186),
      ),
    );
  }
}
