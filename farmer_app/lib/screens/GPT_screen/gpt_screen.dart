import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/screens/GPT_screen/Widgets/ChatItem.dart';
import 'package:farmer_app/screens/GPT_screen/Widgets/FormForchat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:farmer_app/screens/Drawer/Darwer.dart';

class GPTScreen extends StatefulWidget {
  static const routeName = '/gptScreen';
  @override
  State<GPTScreen> createState() => _GPTScreenState();
}

class _GPTScreenState extends State<GPTScreen> {
  final user = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              drawer: AppDrawer(),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: Stack(
                children: [
                  Image.asset(
                    'Assets/Images/background3.jpg',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: Color(0xa6FAEBEB),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.r),
                            ),
                            color: Color(0xa6FAEBEB),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 10.h),
                          margin: EdgeInsets.only(top: 100.h),
                          child: Text(
                            "All My Chats",
                            style: TextStyle(fontSize: 90.sp),
                          ),
                        ),
                      ),
                      Container(
                        height: 500.h,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('chats')
                              .snapshots(),
                          builder: (ctx, chatSnap) {
                            if (chatSnap.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final chatDocs =
                                chatSnap.data!.docs.where((element) {
                              return element['uid'] == user;
                            }).toList();
                            return ListView.builder(
                              itemCount: chatDocs.length,
                              itemBuilder: (ctx, idx) => ChatItem(
                                chatId: chatDocs[idx].id,
                                crop: chatDocs[idx]['crop'],
                                soil: chatDocs[idx]['soil'],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(FormForStartingChat.routeName),
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
