import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.controller,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.enabledBorderColor,
    this.sizedBoxHeight = 55.0,
    this.sizedBoxWidth = double.infinity,
    this.enabled = true,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final Color? enabledBorderColor;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final double? sizedBoxHeight;
  final double? sizedBoxWidth;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizedBoxHeight,
      width: sizedBoxWidth,
      child: TextFormField(
        inputFormatters: inputFormatters,
        enabled: enabled,
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white38, fontSize: 14.sp),
          hintText: hintText ?? '',
          hintStyle: TextStyle(color: Colors.white38, fontSize: 14.sp),
          suffixIcon: suffixIcon,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: enabledBorderColor ?? const Color(0xff242329),
              width: 0.5,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          contentPadding: REdgeInsets.fromLTRB(20.0, 20.0, 10.0, 0.0),
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
