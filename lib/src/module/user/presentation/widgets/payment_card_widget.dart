import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../logic/logic.dart';

class PaymentCardWidget extends StatelessWidget {
  const PaymentCardWidget({
    super.key,
    required this.card,
  });

  final PaymentCardEntity card;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 216,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: card.isCheked! ? Colors.black : AppColors.greyDarker2,
          ),
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 24, vertical: 34),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppAssets.chipIcon(width: 32, height: 24),
                Text(
                  CardUtils.getCardNumberFormatter(card.cardNumber.toString()),
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Holder Name',
                          style: AppTextStyles.white8,
                        ),
                        5.verticalSpace,
                        Text(
                          card.name!,
                          style: AppTextStyles.white12Bold,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expiry Date',
                          style: AppTextStyles.white8,
                        ),
                        5.verticalSpace,
                        Text(
                          '${card.month!}/${card.year!}',
                          style: AppTextStyles.white12Bold,
                        ),
                      ],
                    ),
                    CardUtils.getCardIcon(cardType: card.type)!,
                  ],
                )
              ],
            ),
          ),
        ),
        13.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: card.isCheked,
              activeColor: Colors.white,
              onChanged: (value) {
                if (card.isCheked == false) {
                  BlocProvider.of<PaymentMethodsCubit>(context)
                      .selectDefaultPaymentCard(
                    userId: card.userId!,
                    paymentCardId: card.id!,
                  );
                }
              },
            ),
            Text(
              'Use as default payment method',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        25.verticalSpace,
      ],
    );
  }
}
