import 'package:farmer_app/screens/GPT_screen/IndividualChat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatItem extends StatelessWidget {
  final chatId;
  final crop;
  final soil;
  ChatItem({required this.chatId, required this.crop, required this.soil});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CommunityScreen(
            chatId: chatId,
          ),
        ),
      ),
      child: Container(
        height: 170.h,
        margin: EdgeInsets.symmetric(horizontal: 50.w),
        decoration: BoxDecoration(
          color: Color(0xffFAEBEB),
          borderRadius: BorderRadius.circular(
            30.r,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'Assets/Images/crop.png',
              height: 70.h,
              width: 70.h,
            ),
            Text(
              ' : ' + crop + '  ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 70.sp,
              ),
            ),
            Image.asset(
              'Assets/Images/soil.png',
              height: 70.h,
              width: 70.h,
            ),
            Text(
              ' : ' + soil,
              style: TextStyle(
                color: Colors.black,
                fontSize: 70.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
