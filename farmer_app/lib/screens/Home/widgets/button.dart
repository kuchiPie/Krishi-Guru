import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  final routeName;
  final String imageRoute;
  const Button({required this.routeName, required this.imageRoute});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.r),
        child: Image.asset(
          imageRoute,
          height: 60.h,
        ),
      ),
    );
  }
}
