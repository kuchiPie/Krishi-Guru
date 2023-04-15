import 'package:farmer_app/screens/GPT_screen/IndividualChat.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final chatId;
  final crop;
  final soil;
  ChatItem({required this.chatId, required this.crop, required this.soil});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CommunityScreen(chatId: chatId,),
        ),
      ),
      child: Row(
        children: [
          Text(crop),
          Text(soil),
        ],
      ),
    );
  }
}
