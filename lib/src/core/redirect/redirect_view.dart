import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../module/product/product.dart';
import '../../module/user/user.dart';
import '../core.dart';

const _scaffoldKey = ValueKey('_scaffoldKey');

class Redirect extends StatelessWidget {
  const Redirect({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpVerificationState) {
          context.read<TimerCubit>().startTimer();
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.info(
              backgroundColor: Color.fromARGB(255, 54, 50, 50),
              message: 'The code has been sent. Please check your messages',
            ),
          );
        }
        if (state is AuthFailureState) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: state.error.message,
            ),
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const LoadingWidget();
          } else if (state is UnAuthenticatedState) {
            return const SignInView();
          } else if (state is AuthenticatedState) {
            return HomePage(user: state.user);
          } else if (state is OtpVerificationState) {
            return OtpPage(phoneNumber: state.phoneNumber);
          }

          ///
          return const Scaffold(
            body: Center(
              child: Text('Something went wrong. Try again!'),
            ),
          );
        },
      ),
    );
  }
}
