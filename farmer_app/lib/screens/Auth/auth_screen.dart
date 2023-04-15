import 'package:farmer_app/screens/Home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
// @dart=2.9

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isloading = false;
  signInWithGoogle() async {
    setState(() {
      _isloading = true;
    });
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Falied, Please try again'),
        ),
      );
      setState(() {
      _isloading = false;
    });
      return;
    }
    GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(user);
    print(user);
    setState(() {
      _isloading = false;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  void yourFunction(BuildContext context) async {
    setState(() {
      _isloading = true;
    });
    final user = FirebaseAuth.instance.currentUser;

    try {
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }

      setState(() {
        _isloading = false;
      });
    } on PlatformException catch (error) {
      setState(() {
        _isloading = false;
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
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.center,
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
                            margin: EdgeInsets.symmetric(
                              horizontal: 210.w,
                              vertical: 300.h,
                            ),
                            child: Text(
                              "Krishi Guru",
                              style: TextStyle(fontSize: 90.sp),
                            ),
                          ),
                        ),
                        Container(
                          height: 1300.h,
                          width: 850.w,
                          margin: EdgeInsets.symmetric(horizontal: 50.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 120.w, vertical: 550.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.r),
                            ),
                            color: Color(0xa6FAEBEB),
                          ),
                          child: _isloading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(
                                  height: 100.h,
                                  child: ElevatedButton.icon(
                                    onPressed: signInWithGoogle,
                                    icon: FaIcon(FontAwesomeIcons.google),
                                    label: Text('Sign Up with Google'),
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xffFAEBEB),
                                        onPrimary: Colors.black),
                                  ),
                                ),
                        ),
                      ],
                    ),
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
