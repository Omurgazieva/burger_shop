import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomSheet {
  static showBottomSheet({
    required BuildContext context,
    required String title,
    required Widget content,
    Widget? titleContent,
    double contentPaddingLeft = 16,
    double contentPaddingRight = 16,
    double? contentPaddingBottom,
  }) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: const Color(0xff242329),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Wrap(
            children: [
              SizedBox(
                //height: 352.h,
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: REdgeInsets.only(top: 36),
                        child: titleContent ??
                            Text(
                              title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      ),
                    ),
                    35.verticalSpace,

                    /// content
                    Padding(
                      padding: REdgeInsets.only(
                        left: contentPaddingLeft,
                        right: contentPaddingRight,
                        bottom: contentPaddingBottom ??
                            MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: content,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
