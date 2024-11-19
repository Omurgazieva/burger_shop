import 'package:burger_shop/src/module/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_widgets/app_widgets.dart';

class UpdateNameContent extends StatelessWidget {
  const UpdateNameContent({
    super.key,
    required this.user,
    required this.onTap,
    required this.userNameFormKey,
    required this.nameController,
  });

  final UserEntity user;
  final VoidCallback onTap;
  final GlobalKey<FormState> userNameFormKey;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: userNameFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: nameController,
            sizedBoxHeight: 64.h,
            labelText: 'Name',
          ),
          20.verticalSpace,
          CustomButton(
            onPressed: onTap,
            text: 'SAVE NAME',
          ),
          25.verticalSpace,
        ],
      ),
    );
  }
}
