import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDrawerElement extends StatelessWidget {
  final String routeName;
  final IconData icon;
  final String label;
  const AppDrawerElement({
    required this.routeName,
  required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 30.w),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: Icon(
        icon,
        color: Colors.black,
      ),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(routeName);
      },
    );
  }
}
