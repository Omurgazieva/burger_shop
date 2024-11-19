import 'package:burger_shop/src/module/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../../../module/product/product.dart';
import '../app_widgets.dart';

class SwipeableAnimationButton extends StatefulWidget {
  const SwipeableAnimationButton({
    super.key,
    required this.user,
    required this.onWaitingProcess,
  });

  final UserEntity user;
  final VoidCallback onWaitingProcess;

  @override
  State<SwipeableAnimationButton> createState() =>
      _SwipeableAnimationButtonState();
}

class _SwipeableAnimationButtonState extends State<SwipeableAnimationButton> {
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is AddedOrderState) {
          isFinished = state.isCreated;
          setState(() {});
        }
      },
      child: SizedBox(
        height: 48.h,
        width: 290.w,
        child: SwipeableButtonView(
          onFinish: () async {
            Navigator.push(
              context,
              PageTransition(
                child: CompletedScreen(
                  user: widget.user,
                ),
                type: PageTransitionType.fade,
              ),
            );
          },
          onWaitingProcess: widget.onWaitingProcess,
          isFinished: isFinished,
          activeColor: Colors.orange,
          buttonWidget: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
          buttonText: "  Slide to Pay",
          buttontextstyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // lottie file is in description
            Lottie.network(
              "https://lottie.host/607f2d7f-b29f-401d-b304-776f1024ad5d/y0DTJfrS1Q.json",
              height: 100,
            ),
            Text(
              "Payment Completed",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
                color: Colors.green,
              ),
            ),
            100.verticalSpace,
            CustomButton(
              sizedBoxHeight: 40.h,
              sizedBoxWidth: 180.h,
              text: 'Continue',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      user: user,
                    ),
                  ),
                );
                BlocProvider.of<CartBloc>(context).add(
                  ClearProductCartEvent(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
