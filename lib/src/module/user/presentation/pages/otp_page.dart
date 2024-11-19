import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../user.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key, required this.phoneNumber});

  final String phoneNumber;
  static TextEditingController otpController = TextEditingController();
  static GlobalKey<FormState> smsCodeformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.symmetric(
                horizontal: 30,
                vertical: 200,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    50.verticalSpace,
                    Text(
                      'Enter the received SMS code',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    70.verticalSpace,
                    _pinCodeTextField(context, smsCodeformKey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "If you haven't received the code",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white38,
                          ),
                        ),
                        10.horizontalSpace,
                        BlocBuilder<TimerCubit, TimerState>(
                          builder: (context, state) {
                            if (state is RunTimerState) {
                              return TextButton(
                                onPressed: () {},
                                child: Text(
                                  '${state.time}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.white38,
                                  ),
                                ),
                              );
                            } else if (state is FinishedTimerState) {
                              return TextButton(
                                onPressed: () {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    SignInWithPhoneNumberEvent(
                                      phoneNumber,
                                      context,
                                    ),
                                  );
                                  BlocProvider.of<TimerCubit>(context)
                                      .startTimer();
                                },
                                child: Text(
                                  'Get code',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.blue.withOpacity(0.5),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    ),
                    40.verticalSpace,
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          CancelEvent(),
                        );
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white38,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Form _pinCodeTextField(
      BuildContext context, GlobalKey<FormState> smsCodeformKey) {
    return Form(
      key: smsCodeformKey,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
          child: PinCodeTextField(
            appContext: context,
            pastedTextStyle: TextStyle(
              color: Colors.green.shade600,
              fontWeight: FontWeight.bold,
            ),
            length: 6,
            obscureText: true,
            obscuringCharacter: '*',
            obscuringWidget: const FlutterLogo(
              size: 24,
            ),
            blinkWhenObscuring: true,
            animationType: AnimationType.fade,
            validator: (v) {
              if (v!.length < 6) {
                return "Fill in all fields";
              } else {
                return null;
              }
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              inactiveColor: Colors.white24,
              inactiveFillColor: const Color.fromARGB(255, 54, 50, 50),
            ),
            cursorColor: Colors.black,
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            controller: otpController,
            keyboardType: TextInputType.number,
            boxShadows: const [
              BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black12,
                blurRadius: 10,
              )
            ],
            onChanged: (code) {
              debugPrint(code);
              if (code.length == 6) {
                BlocProvider.of<AuthBloc>(context).add(
                  SendSmsCodeEvent(
                    otpController.text,
                  ),
                );
                //FocusScope.of(context).requestFocus(FocusNode());
              }
            },
            beforeTextPaste: (text) {
              debugPrint("Allowing to paste $text");
              return true;
            },
          )),
    );
  }
}
