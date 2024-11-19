import 'package:burger_shop/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>()..add(GetCurrentUserEvent()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const LoadingWidget();
          } else if (state is AuthenticatedState) {
            final orderList = state.user.orders as List<OrderEntity>;
            return NestedOrdersPage(
              delivered:
                  orderList.where((i) => i.status == 'delivered').toList(),
              processing:
                  orderList.where((i) => i.status == 'processing').toList(),
              cancelled:
                  orderList.where((i) => i.status == 'cancelled').toList(),
            );
          } else if (state is AuthFailureState) {
            return MyErrorWidget(message: state.error.toString());
          }
          return const Text('Some Error');
        },
      ),
    );
  }
}

class NestedOrdersPage extends StatelessWidget {
  NestedOrdersPage({
    required this.delivered,
    required this.processing,
    required this.cancelled,
    super.key,
  });

  final List<OrderEntity> delivered;
  final List<OrderEntity> processing;
  final List<OrderEntity> cancelled;

  final _items = ['Delivered', 'Processing', 'Cancelled'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: REdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Orders',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TabBar(
                padding: REdgeInsets.symmetric(vertical: 21),
                dividerHeight: 0,
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.orange,
                labelStyle: TextStyle(fontSize: 12.sp),
                unselectedLabelStyle: TextStyle(fontSize: 12.sp),
                unselectedLabelColor: Colors.white,
                tabs: _items.map((e) => Tab(text: e, height: 35)).toList(),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    OrdersListView(allOrders: delivered),
                    OrdersListView(allOrders: processing),
                    OrdersListView(allOrders: cancelled),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
