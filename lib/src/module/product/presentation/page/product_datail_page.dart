import 'package:burger_shop/src/module/product/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';
import '../logic/logic.dart';

class ProductDatailPage extends StatelessWidget {
  const ProductDatailPage({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CounterCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xff242329),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            CachedNetworkImageWidget(
              imageUrl: product.datailImgUrl!,
              height: 290.h,
              width: double.infinity,
            ),
            30.verticalSpace,
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                children: [
                  Text(
                    product.productDatailTitle!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    product.description!,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12.sp,
                    ),
                  ),
                  40.verticalSpace,

                  //increment-decrement button
                  BlocBuilder<CounterCubit, CounterState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(0xff19191D),
                            ),
                            height: 47.h,
                            child: Padding(
                              padding: REdgeInsets.symmetric(
                                vertical: 5.0,
                              ),
                              child: Row(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: const CircleBorder(),
                                      padding: REdgeInsets.all(1),
                                    ),
                                    onPressed: () =>
                                        BlocProvider.of<CounterCubit>(context)
                                            .decrement(
                                      product.price!,
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${state.quantity}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: const CircleBorder(),
                                      padding: REdgeInsets.all(1),
                                    ),
                                    onPressed: () =>
                                        BlocProvider.of<CounterCubit>(context)
                                            .increment(
                                      product.price!,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          70.horizontalSpace,

                          // Total price
                          Column(
                            children: [
                              Text(
                                'Total prise',
                                style: TextStyle(
                                    fontSize: 8.sp, color: Colors.white),
                              ),
                              5.verticalSpace,
                              Text(
                                state.cardTotalPrice == 0.0
                                    ? '\$${product.price}'
                                    : '\$${state.cardTotalPrice}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  40.verticalSpace,

                  // Button
                  BlocBuilder<CounterCubit, CounterState>(
                    builder: (context, state) {
                      return CustomButton(
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context).add(
                            AddProductToCartEvent(
                              CartEntity(
                                productId: product.id,
                                productName: product.productName,
                                price: product.price,
                                cardTotalPrice: state.cardTotalPrice,
                                quantity: state.quantity,
                                mainImgUrl: product.mainImgUrl,
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        text: 'ADD TO CART',
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
