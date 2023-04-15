import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:farmer_app/screens/Auth/auth_screen.dart';
import 'package:intl/intl.dart';
import './widgets/button.dart';

// @dart=2.9
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName = FirebaseAuth.instance.currentUser?.displayName;
  // String userName = u;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              drawer: Drawer(),
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
                      Container(
                        margin: EdgeInsets.only(top: 300.h, left: 100.w),
                        child: Text(
                          'Welcome, ' + userName!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 100.sp,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 28.w),
                        child: Text(
                          DateFormat.yMMMd().format(DateTime.now()),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 60.sp,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 1200.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 200.w,
                              child: TextButton(
                                onPressed: () {},
                                child: Image.asset(
                                    'Assets/Images/ask_chatgtp.png'),
                              ),
                            ),
                            Container(
                              width: 200.w,
                              child: TextButton(
                                onPressed: () {},
                                child:
                                    Image.asset('Assets/Images/community.png'),
                              ),
                            ),
                            Container(
                              width: 200.w,
                              child: TextButton(
                                onPressed: () {},
                                child: Image.asset('Assets/Images/sunny.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
