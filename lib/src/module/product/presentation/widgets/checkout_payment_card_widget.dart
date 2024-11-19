import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';
import '../../../user/user.dart';
import 'widgets.dart';

class CheckoutPaymentCardWidget extends StatefulWidget {
  const CheckoutPaymentCardWidget(
      {required this.user, required this.paymentCard, super.key});

  final UserEntity user;
  final PaymentCardEntity paymentCard;

  @override
  State<CheckoutPaymentCardWidget> createState() =>
      _CheckoutPaymentCardWidgetState();
}

class _CheckoutPaymentCardWidgetState extends State<CheckoutPaymentCardWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.paymentCard != PaymentCardEntity()
        ? Column(
            children: [
              Padding(
                padding: REdgeInsets.only(right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CheckoutTitleWidget(text: 'Payment'),
                    InkWell(
                      onTap: () async {
                        final isTrue = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentMethodsPage(
                              user: widget.user,
                            ),
                          ),
                        );
                        if (isTrue) {
                          setState(() {
                            context.read<ProfileBloc>().add(
                                  GetUserInfoEvent(widget.user.userID!),
                                );
                          });
                        }
                      },
                      child: Text(
                        'Change',
                        style: AppTextStyles.red10,
                      ),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
              Row(
                children: [
                  Container(
                    height: 38.h,
                    width: 64.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: CardUtils.getCardIcon(
                        cardType: widget.paymentCard.type),
                  ),
                  17.horizontalSpace,
                  Text(
                    CardUtils.getCardNumberFormatter(
                        widget.paymentCard.cardNumber.toString()),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          )
        : SizedBox(
            height: 80.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: REdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CheckoutTitleWidget(text: 'Payment'),
                      InkWell(
                        onTap: () async {
                          final isTrue = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentMethodsPage(
                                user: widget.user,
                              ),
                            ),
                          );
                          if (isTrue) {
                            setState(() {
                              context.read<ProfileBloc>().add(
                                    GetUserInfoEvent(widget.user.userID!),
                                  );
                            });
                          }
                        },
                        child: Text(
                          'Change',
                          style: AppTextStyles.red12,
                        ),
                      ),
                    ],
                  ),
                ),
                30.verticalSpace,
                Text(
                  'Payment card not selected!',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
  }
}
