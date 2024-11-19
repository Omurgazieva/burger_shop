import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_widgets/app_widgets.dart';
import '../../../user/user.dart';
import '../../product.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartBloc>(context).add(
      GetAllProductFromCartEvent(),
    );

    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is DeletedProductFromCartState) {
          BlocProvider.of<CartBloc>(context).add(
            GetAllProductFromCartEvent(),
          );
        }
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is LoadingBagState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedAllProductsFromCartState) {
            return NestedCartPage(
              userId: userId,
              allProducts: state.allProducts,
              totalAmount: state.totalAmount,
            );
          } else if (state is CartFailureState) {
            return MyErrorWidget(message: state.message);
          }
          return const Text('Some error');
        },
      ),
    );
  }
}

class NestedCartPage extends StatelessWidget {
  const NestedCartPage({
    super.key,
    required this.userId,
    required this.allProducts,
    required this.totalAmount,
  });

  final String userId;

  final List<CartEntity> allProducts;
  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        'Cart page',
        style: TextStyle(fontSize: 18.sp),
      ),
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  buildBody(BuildContext context) {
    return allProducts.isNotEmpty
        ? SingleChildScrollView(
            child: Padding(
              padding:
                  REdgeInsets.only(top: 16, left: 16, right: 16, bottom: 20),
              child: Column(
                children: [
                  /// Product List
                  Container(
                    constraints: BoxConstraints(minHeight: 580.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: allProducts.length,
                      itemBuilder: (context, index) {
                        final product = allProducts[index];

                        return BlocProvider.value(
                          value: BlocProvider.of<CartBloc>(context),
                          child: CartCard(
                            product: product,
                          ),
                        );
                      },
                    ),
                  ),
                  25.verticalSpace,
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total amount:',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.h,
                          ),
                        ),
                        Text(
                          '\$$totalAmount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Button
                  25.verticalSpace,

                  CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPage(
                            userId: userId,
                            order: OrderEntity(
                              items: allProducts,
                              shippingAddress: ShippingAddressEntity(),
                              paymentMethod: PaymentCardEntity(),
                              deliveryMethod: '',
                              totalAmount: totalAmount,
                            ),
                          ),
                        ),
                      );
                    },
                    text: 'CHECK OUT',
                  ),
                ],
              ),
            ),
          )
        : Align(
            alignment: Alignment.center,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_shopping_cart,
                    color: Colors.grey,
                    size: 100.h,
                  ),
                  50.verticalSpace,
                  Text(
                    'Cart is empty!',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.h,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
