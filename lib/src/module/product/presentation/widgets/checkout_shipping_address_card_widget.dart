import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';
import '../../../user/user.dart';

class CheckoutShippingAddressCardWidget extends StatefulWidget {
  const CheckoutShippingAddressCardWidget({
    required this.user,
    required this.shippingAddress,
    super.key,
  });

  final UserEntity user;
  final ShippingAddressEntity shippingAddress;

  @override
  State<CheckoutShippingAddressCardWidget> createState() =>
      _CheckoutShippingAddressCardWidgetState();
}

class _CheckoutShippingAddressCardWidgetState
    extends State<CheckoutShippingAddressCardWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.shippingAddress != ShippingAddressEntity()
        ? SizedBox(
            child: Card(
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 25, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.shippingAddress.userName!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final isTrue = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShippingAddressPage(
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
                          child: Text('Change', style: AppTextStyles.red10),
                        ),
                      ],
                    ),
                    12.verticalSpace,
                    Text(
                      widget.shippingAddress.address!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                      ),
                    ),
                    5.verticalSpace,
                    Text(
                      '${widget.shippingAddress.city}, ${widget.shippingAddress.country}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Card(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 25, vertical: 18),
              child: SizedBox(
                height: 70.h,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Shipping address not selected!',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.verticalSpace,
                    InkWell(
                      onTap: () async {
                        final isTrue = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShippingAddressPage(
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
                      child: Text('Change', style: AppTextStyles.red10),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
