import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';
import '../../user.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({
    required this.user,
    super.key,
  });

  final UserEntity user;

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PaymentMethodsCubit>(),
      child: BlocListener<PaymentMethodsCubit, PaymentMethodsState>(
        listener: (context, state) {
          if (state is AddedPaymentCardState) {
            BlocProvider.of<PaymentMethodsCubit>(context).getAllPaymentCards(
              userId: user.userID!,
            );
          }

          if (state is SelectedPaymentCardState) {
            BlocProvider.of<PaymentMethodsCubit>(context).getAllPaymentCards(
              userId: user.userID!,
            );
          }
        },
        child: BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
          builder: (context, state) {
            if (state is LoadingPaymentMethodsState) {
              return const LoadingWidget();
            } else if (state is PaymentMethodsInitial) {
              return NestedPaymentMethodsView(
                paymentCards: user.paymentMethods as List<PaymentCardEntity>,
                user: user,
              );
            } else if (state is LoadedAllPaymentCardsState) {
              return NestedPaymentMethodsView(
                paymentCards: state.paymentCards,
                user: user,
              );
            } else if (state is PaymentCardFailureState) {
              return MyErrorWidget(message: state.message.toString());
            }
            return const Text('Some error');
          },
        ),
      ),
    );
  }
}

class NestedPaymentMethodsView extends StatelessWidget {
  const NestedPaymentMethodsView({
    required this.paymentCards,
    required this.user,
    super.key,
  });

  final List<PaymentCardEntity> paymentCards;
  final UserEntity user;

  static GlobalKey<FormState> paymentMethodFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final cardNumberController = TextEditingController();
    final expireDateController = TextEditingController();
    final cvvController = TextEditingController();

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Payment methods',
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your payment cards',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
                30.verticalSpace,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  //itemExtent: 140.h,
                  padding: REdgeInsets.all(0),
                  itemCount: paymentCards.length,
                  itemBuilder: (context, index) {
                    final card = paymentCards[index];
                    return BlocProvider.value(
                      value: BlocProvider.of<PaymentMethodsCubit>(context),
                      child: PaymentCardWidget(
                        card: card,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          height: 80,
          child: Padding(
            padding: REdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  sizedBoxHeight: 36.w,
                  sizedBoxWidth: 160.w,
                  isOutlinedButton: true,
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  textStyle: TextStyle(color: Colors.white, fontSize: 10.sp),
                  text: 'BACK',
                ),
                CustomButton(
                  sizedBoxHeight: 36.w,
                  sizedBoxWidth: 160.w,
                  onPressed: () {
                    AppBottomSheet.showBottomSheet(
                      context: context,
                      title: 'Adding payment card',
                      content: addCardBottomSheetContent(
                        context: context,
                        formKey: paymentMethodFormKey,
                        nameController: nameController,
                        cardNumberController: cardNumberController,
                        expireDateController: expireDateController,
                        cvvController: cvvController,
                      ),
                    );
                  },
                  textStyle: TextStyle(color: Colors.white, fontSize: 10.sp),
                  text: 'ADD NEW CARD',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addCardBottomSheetContent({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController cardNumberController,
    required TextEditingController expireDateController,
    required TextEditingController cvvController,
  }) {
    bool isChecked = true;

    return BlocProvider(
      create: (context) => sl<PaymentCardNumberCubit>(),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: nameController,
              sizedBoxHeight: 64.h,
              sizedBoxWidth: double.infinity,
              labelText: 'Name on card',
              validator: (String? value) =>
                  value!.isEmpty ? Strings.fieldReq : null,
            ),
            10.verticalSpace,
            BlocBuilder<PaymentCardNumberCubit, PaymentCardNumberState>(
              builder: (context, state) {
                return CustomTextFormField(
                  controller: cardNumberController,
                  sizedBoxHeight: 64.h,
                  sizedBoxWidth: double.infinity,
                  labelText: 'Card number',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                    CardNumberInputFormatter()
                  ],
                  validator: CardUtils.validateCardNum,
                  suffixIcon: CardUtils.getCardIcon(cardType: state.cardType),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => context
                      .read<PaymentCardNumberCubit>()
                      .getCardTypeFrmNumber(value),
                );
              },
            ),
            10.verticalSpace,
            CustomTextFormField(
              controller: expireDateController,
              sizedBoxHeight: 64.h,
              sizedBoxWidth: double.infinity,
              labelText: 'Expire date',
              hintText: 'MM/YY',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
                CardMonthInputFormatter()
              ],
              validator: CardUtils.validateDate,
              keyboardType: TextInputType.number,
            ),
            10.verticalSpace,
            CustomTextFormField(
              controller: cvvController,
              sizedBoxHeight: 64.h,
              sizedBoxWidth: double.infinity,
              labelText: 'cvv',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              suffixIcon: AppAssets.helperIcon(width: 0.2.h, height: 0.2.h),
              validator: CardUtils.validateCVV,
              keyboardType: TextInputType.number,
            ),
            10.verticalSpace,
            CustomCheckBox(
              isCheckedCallback: (value) => isChecked = value,
              isTitle: true,
              title: 'Set as default payment method',
            ),
            20.verticalSpace,
            CustomButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<PaymentMethodsCubit>(context)
                      .addNewPaymentCard(
                    newCard: PaymentCardEntity(
                      userId: user.userID,
                      name: nameController.text,
                      cardNumber:
                          CardUtils.getCleanedNumber(cardNumberController.text),
                      month:
                          CardUtils.getExpiryDate(expireDateController.text)[0],
                      year:
                          CardUtils.getExpiryDate(expireDateController.text)[1],
                      cvv: int.parse(cvvController.text),
                      isCheked: isChecked,
                    ),
                  );
                  nameController.clear();
                  cardNumberController.clear();
                  expireDateController.clear();
                  cvvController.clear();
                  Navigator.pop(context);
                }
              },
              text: 'ADD CARD',
            ),
            25.verticalSpace,
          ],
        ),
      ),
    );
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }
}
