import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlinedButton = false,
    this.sizedBoxHeight = 48.0,
    this.sizedBoxWidth = double.infinity,
    this.bgColor = Colors.orange,
    this.textStyle,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isOutlinedButton;
  final double sizedBoxHeight;
  final double sizedBoxWidth;
  final Color bgColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    // Elevated Button Style
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      minimumSize: Size(sizedBoxWidth, sizedBoxHeight),
      padding: REdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      backgroundColor: Colors.orange,
    );

    // Outlined Button Style
    final ButtonStyle buttonStyles = OutlinedButton.styleFrom(
      minimumSize: Size(sizedBoxWidth, sizedBoxHeight),
      padding: REdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      side: const BorderSide(
        color: Colors.white,
      ),
    );

    return !isOutlinedButton
        ? ElevatedButton(
            style: buttonStyle,
            onPressed: onPressed,
            child: Text(
              text,
              style: textStyle ??
                  TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
            ),
          )
        : OutlinedButton(
            style: buttonStyles,
            onPressed: onPressed,
            child: Text(
              text,
              style: textStyle ??
                  TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
            ),
          );
  }
}
