import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_widgets/app_widgets.dart';
import '../../../product/domain/entities/entities.dart';
import '../../user.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, required this.allOrders});

  final List<OrderEntity> allOrders;

  String capitalize(String text) =>
      '${text[0].toUpperCase()}${text.substring(1)}';

  @override
  Widget build(BuildContext context) {
    return allOrders.isNotEmpty
        ? ListView.builder(
            itemCount: allOrders.length,
            itemBuilder: (context, index) {
              final order = allOrders[index];
              return Card(
                child: Padding(
                  padding: REdgeInsets.all(19.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order №${order.orderNumber}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          DateTimeFormatter.dateTimeFormater(
                              order.createdDate!),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Tracking number:   ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          '${order.trackingNumber}',
                          style: TextStyle(
                            color: Colors.white,
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
                              'Quantity:   ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              '${order.items!.length}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Total Amount:   ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              '${order.totalAmount}\$',
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
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: REdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            side: const BorderSide(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailsPage(
                                  order: order,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        Text(
                          capitalize(order.status!),
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              );
            },
          )
        : Align(
            alignment: Alignment.center,
            child: Text(
              'Empty',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.sp,
              ),
            ),
          );
  }
}
