import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    required this.message,
    super.key,
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: REdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              40.verticalSpace,
              Text(
                message,
                textAlign: TextAlign.center,
              ),
              100.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
