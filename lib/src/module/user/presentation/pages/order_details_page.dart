import 'package:burger_shop/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({
    required this.order,
    super.key,
  });

  final OrderEntity order;

  String capitalize(String text) =>
      '${text[0].toUpperCase()}${text.substring(1)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Order datails',
          style: TextStyle(fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order №${order.orderNumber}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateTimeFormatter.dateTimeFormater(order.createdDate!),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  15.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Tracking number:  ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text('${order.trackingNumber}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Text(capitalize(order.status!),
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12.sp,
                              )),
                        ],
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  Text('${order.items!.length} items',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      )),
                ],
              ),
              30.verticalSpace,

              /// Product List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: order.items!.length,
                //itemExtent: 150.h,
                itemBuilder: (context, index) {
                  final product = order.items![index];
                  return Padding(
                    padding: REdgeInsets.only(bottom: 15),
                    child: OrderDetailCard(
                      product: product,
                    ),
                  );
                },
              ),
              30.verticalSpace,

              /// Order information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  34.verticalSpace,
                  Text('Order information',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      )),
                  25.verticalSpace,
                  Row(
                    children: [
                      Column(
                        children: [
                          Text('Shipping Address:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.sp,
                              )),
                          5.verticalSpace,
                          Text('',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.sp,
                              )),
                        ],
                      ),
                      15.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${order.shippingAddress!.address}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              )),
                          5.verticalSpace,
                          Text(
                              '${order.shippingAddress!.city},  ${order.shippingAddress!.country}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ],
                  ),
                  25.verticalSpace,
                  Row(
                    children: [
                      Text('Payment method:',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                          )),
                      21.horizontalSpace,
                      Row(
                        children: [
                          CardUtils.getCardIcon(
                            cardType: order.paymentMethod!.type,
                            width: 35.w,
                            height: 35.h,
                          )!,
                          Text(
                            CardUtils.getCardNumberFormatter(
                                order.paymentMethod!.cardNumber.toString()),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  25.verticalSpace,
                  Row(
                    children: [
                      Text('Delivery method:',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                          )),
                      27.horizontalSpace,
                      Text(
                        '${order.deliveryMethod}\$',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  25.verticalSpace,
                  Row(
                    children: [
                      Text('Total Amount:',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                          )),
                      42.horizontalSpace,
                      Text(
                        '\$${order.totalAmount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  50.verticalSpace,

                  /// buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        sizedBoxHeight: 36.w,
                        sizedBoxWidth: 160.w,
                        isOutlinedButton: true,
                        onPressed: () {},
                        text: 'Reorder',
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 11.sp),
                      ),
                      CustomButton(
                        sizedBoxHeight: 36.w,
                        sizedBoxWidth: 160.w,
                        onPressed: () {},
                        text: 'Leave feedback',
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 11.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
