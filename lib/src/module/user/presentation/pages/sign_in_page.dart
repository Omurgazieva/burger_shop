import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';
import '../../user.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String phoneNumber = '';

    return Scaffold(
      body: Padding(
        padding: REdgeInsets.only(left: 25, right: 25, top: 150, bottom: 25),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                80.verticalSpace,

                /// Phone number
                PhoneNumberInput(
                  phoneNumberCallback: (value) => phoneNumber = value,
                ),

                50.verticalSpace,

                /// Button
                CustomButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<AuthBloc>(context).add(
                        SignInWithPhoneNumberEvent(
                          phoneNumber,
                          context,
                        ),
                      );
                    }
                  },
                  text: 'Continue',
                ),
                160.verticalSpace,
                Text(
                  'Or sign in with social account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
                50.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: AppAssets.facebookLogo(width: 50.h, height: 50.h),
                      onPressed: () {},
                    ),
                    30.horizontalSpace,
                    IconButton(
                      icon: AppAssets.googleLogo(width: 47.h, height: 47.h),
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          SignInWithGoogleEvent(),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
