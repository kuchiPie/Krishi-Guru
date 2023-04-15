import 'package:farmer_app/Components/logout_button.dart';
import 'package:farmer_app/screens/Drawer/Components/AppDrawerElement.dart';
import 'package:farmer_app/screens/GPT_screen/gpt_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
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
            child: Column(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.r),
                      ),
                      color: Color(0xa6FAEBEB),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 300.h,
                    ),
                    child: Text(
                      "Krishi Guru",
                      style: TextStyle(fontSize: 85.sp),
                    ),
                  ),
                ),
                AppDrawerElement(
                    routeName: GPTScreen.routeName,
                    icon: Icons.question_answer,
                    label: 'Ask AI Krishi'),
                SizedBox(
                  height: 1000.h,
                ),
                LogoutButton(Buttontext: 'Logout'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
