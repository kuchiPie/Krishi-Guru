// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:farmer_app/screens/GPT_screen/Widgets/ChatItem.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Chats extends StatelessWidget {
//   const Chats({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final uid = FirebaseAuth.instance.currentUser!.uid;
//     // return StreamBuilder(
//     //   stream: FirebaseFirestore.instance
//     //       .collection('chats')
//     //       .orderBy('createdAt', descending: true)
//     //       .snapshots(),
//     //   builder: (ctx, chatSnap) {
//     //     if (chatSnap.connectionState == ConnectionState.waiting) {
//     //       return Center(
//     //         child: CircularProgressIndicator(),
//     //       );
//     //     }
//     //     final chatDocs =
//     //         chatSnap.data!.docs.where((element) => element['uid']==uid);
//     //     print(chatDocs);
//     //     return ListView.builder(itemBuilder: (ctx, index) => ChatItem(chatId: chatDocs[index].id, crop: chatDocs[index]['crop'], soil: chatDocs[index]['soil']),itemCount: chatDocs.length,);
//     //   },
//     // );
//     return StreamBuilder(builder: )
//   }
// }
