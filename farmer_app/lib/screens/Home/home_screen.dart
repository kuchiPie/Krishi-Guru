import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_app/screens/Drawer/Darwer.dart';
import 'package:farmer_app/screens/GPT_screen/gpt_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:farmer_app/screens/Auth/auth_screen.dart';
import 'package:intl/intl.dart';
import './widgets/button.dart';
import 'package:location/location.dart';
import '../../models/weather.dart' as W;

// @dart=2.9
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = false;
  String? userName = FirebaseAuth.instance.currentUser?.displayName;
  String res = "err";

  void yourFunction(BuildContext context) async {
    setState(() {
      _loading = true;
    });
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final name = FirebaseAuth.instance.currentUser!.displayName;
    final email = FirebaseAuth.instance.currentUser!.email;
    LocationData locData;
    try {
      bool _flag = false;
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      print(doc.docs.length);
      if (doc.docs.length == 0) {
        await FirebaseFirestore.instance
            .doc('users/' + uid)
            .set({'uid': uid, 'name': name, 'email': email});
      }

      locData = await Location().getLocation();
      res = await W.getWeatherData(
          locData.latitude.toString(), locData.longitude.toString());
      print(res);
      setState(() {
        _loading = false;
      });
    } on PlatformException catch (error) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => yourFunction(context));
  }

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
                  _loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
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
                              height: 600.h,
                              margin: EdgeInsets.symmetric(
                                horizontal: 200.w,
                                vertical: 400.h,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 106, 177, 224),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50.w, vertical: 50.h),
                                child: Center(
                                  child: Text(
                                    res == 'err'
                                        ? "Something went wrong"
                                        : "Temp : ${res} C",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 80.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 200.w,
                                    child: TextButton(
                                      onPressed: () => Navigator.of(context)
                                          .pushNamed(GPTScreen.routeName),
                                      child: Image.asset(
                                          'Assets/Images/ask_chatgtp.png'),
                                    ),
                                  ),
                                  Container(
                                    width: 200.w,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Image.asset(
                                          'Assets/Images/community.png'),
                                    ),
                                  ),
                                  Container(
                                    width: 200.w,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Image.asset(
                                          'Assets/Images/sunny.png'),
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
