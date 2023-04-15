import 'package:farmer_app/screens/GPT_screen/Widgets/NewMessage.dart';
import 'package:farmer_app/screens/GPT_screen/Widgets/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityScreen extends StatelessWidget {
  static const routeName = '/individualChat';
  final chatId;
  CommunityScreen({required this.chatId});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
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
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 130.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 28.w),
                            child: Text(
                              'Chat with AI Guru',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 85.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 30.h, left: 30.w, right: 30.w),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.h),
                              decoration: BoxDecoration(
                                color: Color(0xB0FFDFB0),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              height: 2000.h,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Messages(
                                      chatId: chatId,
                                    ),
                                  ),
                                  NewMessage(
                                    chatId: chatId,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
