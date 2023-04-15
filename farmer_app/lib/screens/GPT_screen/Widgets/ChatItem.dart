import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final chatId;
  final crop;
  final soil;
  ChatItem({required this.chatId, required this.crop, required this.soil});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Pressed"),
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
