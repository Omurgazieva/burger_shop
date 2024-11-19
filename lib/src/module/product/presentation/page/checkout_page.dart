import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/core.dart';
import '../../../user/user.dart';
import '../../product.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({
    required this.order,
    required this.userId,
    super.key,
  });

  final OrderEntity order;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProfileBloc>()..add(GetUserInfoEvent(userId)),
        ),
      ],
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileInitial) {
            BlocProvider.of<ProfileBloc>(context).add(GetUserInfoEvent(userId));
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is LoadingProfileState) {
              return const LoadingWidget();
            } else if (state is LoadedUserProfileState) {
              final ShippingAddressEntity shippingAddress;
              final PaymentCardEntity paymentCard;
              shippingAddress = state.user.shippingAddresses!.isNotEmpty
                  ? state.user.shippingAddresses!
                      .firstWhere((e) => e.isCheked == true)
                  : ShippingAddressEntity();
              paymentCard = state.user.paymentMethods!.isNotEmpty
                  ? state.user.paymentMethods!
                      .firstWhere((e) => e.isCheked == true)
                  : PaymentCardEntity();

              return NestedCheckoutView(
                order: order,
                user: state.user,
                shippingAddress: shippingAddress,
                paymentCard: paymentCard,
              );
            }
            return const Center(
                child: Text(
              'Some Error',
              style: TextStyle(color: Colors.white),
            ));
          },
        ),
      ),
    );
  }
}

class NestedCheckoutView extends StatefulWidget {
  final OrderEntity order;
  final UserEntity user;
  final ShippingAddressEntity shippingAddress;
  final PaymentCardEntity paymentCard;

  const NestedCheckoutView({
    super.key,
    required this.order,
    required this.user,
    required this.shippingAddress,
    required this.paymentCard,
  });

  @override
  State<NestedCheckoutView> createState() => _NestedCheckoutViewState();
}

class _NestedCheckoutViewState extends State<NestedCheckoutView> {
  ShippingAddressEntity getShippingAddress(
      List<ShippingAddressEntity> addresses) {
    return addresses.firstWhere((e) => e.isCheked == true);
  }

  PaymentCardEntity getPaymentCard(List<PaymentCardEntity> cards) {
    return cards.firstWhere((e) => e.isCheked == true);
  }

  bool isFinished = false;
  ShippingAddressEntity newaddress = ShippingAddressEntity();

  DeliveryEntity selectedDeliveryMethod = DeliveryEntity(
    id: '0',
    name: 'FedEx',
    days: 3,
    price: 15,
    image: AppAssets.fedex(width: 60.h, height: 37.h),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Checkout',
          style: TextStyle(fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 20), // 36
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CheckoutTitleWidget(text: 'Shipping address'),
            15.verticalSpace,
            BlocProvider.value(
              value: BlocProvider.of<ProfileBloc>(context),
              child: CheckoutShippingAddressCardWidget(
                user: widget.user,
                shippingAddress: widget.shippingAddress,
              ),
            ),
            57.verticalSpace,

            /// Payment method
            BlocProvider.value(
              value: BlocProvider.of<ProfileBloc>(context),
              child: CheckoutPaymentCardWidget(
                user: widget.user,
                paymentCard: widget.paymentCard,
              ),
            ),
            57.verticalSpace,

            /// Delivery method
            const CheckoutTitleWidget(text: 'Delivery method'),
            15.verticalSpace,
            DeliveryCardToggleButton(
              selectedItemsCallback: (value) => setState(() {
                selectedDeliveryMethod = value;
              }),
            ),
            40.verticalSpace,

            /// Order info
            buildOrder(text: 'Order:', value: widget.order.totalAmount!),
            14.verticalSpace,
            buildOrder(text: 'Delivery:', value: selectedDeliveryMethod.price!),
            14.verticalSpace,
            buildOrder(
              text: 'Summary:',
              value:
                  (widget.order.totalAmount! + selectedDeliveryMethod.price!),
            ),
            40.verticalSpace,

            /// Button
            Align(
              alignment: Alignment.center,
              child: SwipeableAnimationButton(
                onWaitingProcess: () {
                  if (widget.shippingAddress == ShippingAddressEntity()) {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        backgroundColor: Color.fromARGB(255, 54, 50, 50),
                        message: 'Add shipping adress',
                      ),
                    );
                  } else if (widget.paymentCard == PaymentCardEntity()) {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        backgroundColor: Color.fromARGB(255, 54, 50, 50),
                        message: 'Add payment card',
                      ),
                    );
                  } else {
                    BlocProvider.of<CartBloc>(context).add(
                      AddOrderEvent(
                        OrderEntity(
                          orderNumber: 1947034,
                          userID: widget.user.userID,
                          userName: widget.user.name,
                          trackingNumber: 'IW3475453455',
                          items: widget.order.items,
                          shippingAddress: widget.shippingAddress,
                          paymentMethod: widget.paymentCard,
                          deliveryMethod:
                              '${selectedDeliveryMethod.name}, ${selectedDeliveryMethod.days} days, ${selectedDeliveryMethod.price}',
                          totalAmount: (widget.order.totalAmount! +
                              selectedDeliveryMethod.price!),
                        ),
                      ),
                    );
                  }
                },
                user: widget.user,
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildOrder({required String text, required double value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppTextStyles.grey12,
        ),
        Text(
          '\$$value',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
