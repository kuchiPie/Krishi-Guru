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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: Color(0xffFAEBEB),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 100.w),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 70.sp,
          ),
        ),
        trailing: Icon(
          icon,
          color: Colors.black,
        ),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(routeName);
        },
      ),
    );
  }
}
