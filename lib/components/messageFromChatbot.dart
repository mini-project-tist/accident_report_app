import 'package:flutter/material.dart';
class ChatbotMessage extends StatelessWidget {
  const ChatbotMessage({super.key,
    required this.chatbotMessage});
  final String chatbotMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 300.0,
      ),
      decoration:  const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        color: Color(0xff393186),
      ),
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          chatbotMessage,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}