import 'package:farmer_app/screens/GPT_screen/Widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  final chatId;
  Messages({required this.chatId});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(chatId)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatChapshot) {
        if (chatChapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatChapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemBuilder: (ctx, index) => MessageBubble(
            chatDocs[index]['text'],
            chatDocs[index]['userId'] == user!.uid,
            chatDocs[index]['name'],
            key: ValueKey(
              chatDocs[index].hashCode,
            ),
          ),
          itemCount: chatDocs.length,
        );
      },
    );
  }
}
