import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/Auth/auth_screen.dart';

class LogoutButton extends StatelessWidget {
  final String Buttontext;
  LogoutButton({required this.Buttontext});

  @override
  Widget build(BuildContext context) {
    void logOut() async {
      await FirebaseAuth.instance.signOut();
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: logOut,
      icon: Icon(
        Icons.logout,
        color: Colors.black,
      ),
      label: Text(Buttontext),
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).errorColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
