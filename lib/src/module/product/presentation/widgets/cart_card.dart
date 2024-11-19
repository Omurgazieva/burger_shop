import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../logic/logic.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    super.key,
    required this.product,
  });

  final CartEntity product;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  double totalCardAmount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CounterCubit>()
        ..getPrise(
          widget.product.price!,
          widget.product.quantity!,
        ),
      child: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          context.read<CartBloc>().add(
                AddNewQuantityEvent(
                  CartEntity(
                    productId: widget.product.productId,
                    productName: widget.product.productName,
                    price: widget.product.price,
                    cardTotalPrice: state.cardTotalPrice,
                    quantity: state.quantity,
                    mainImgUrl: widget.product.mainImgUrl,
                  ),
                ),
              );
        },
        child: Stack(
          children: [
            Card(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0.r),
              ),
              child: SizedBox(
                height: 135.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// Image
                    Padding(
                      padding: REdgeInsets.all(15.0),
                      child: CachedNetworkImageWidget(
                        imageUrl: widget.product.mainImgUrl!,
                        height: 85.h,
                        width: 85.w,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: REdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 25,
                        ),
                        child: SizedBox(
                          height: 100.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.product.productName!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              /// Counter
                              BlocBuilder<CounterCubit, CounterState>(
                                builder: (context, state) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            /// Increment
                                            SizedBox(
                                              height: 36.h,
                                              width: 36.h,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  shape: const CircleBorder(),
                                                  padding: REdgeInsets.all(1),
                                                ),
                                                onPressed: () => BlocProvider
                                                        .of<CounterCubit>(
                                                            context)
                                                    .decrement(
                                                  widget.product.price!,
                                                ),
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            16.horizontalSpace,

                                            /// Quantity
                                            Text(
                                              '${widget.product.quantity}',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                            16.horizontalSpace,

                                            /// Decrement

                                            SizedBox(
                                              height: 36.h,
                                              width: 36.h,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  shape: const CircleBorder(),
                                                  padding: REdgeInsets.all(1),
                                                ),
                                                onPressed: () => BlocProvider
                                                        .of<CounterCubit>(
                                                            context)
                                                    .increment(
                                                  widget.product.price!,
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //Prise
                                      Text(
                                        '${widget.product.cardTotalPrice}\$',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5.h,
              right: 2.h,
              child: popUpMenuBtn(),
            ),
          ],
        ),
      ),
    );
  }

  popUpMenuBtn() {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        size: 25.h,
        color: Colors.grey,
      ),
      onSelected: (e) => BlocProvider.of<CartBloc>(context).add(
        DeleteProductFromCartEvent(widget.product.productId!),
      ),
      itemBuilder: (BuildContext context) {
        return Constants.choices.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(
              choice,
              style: TextStyle(color: Colors.white, fontSize: 11.sp),
            ),
          );
        }).toList();
      },
    );
  }
}

class Constants {
  static const List<String> choices = <String>[
    'Delete from the list',
  ];
}
