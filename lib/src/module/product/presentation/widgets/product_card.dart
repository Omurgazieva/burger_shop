import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';
import '../../product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, super.key});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDatailPage(
                    product: product,
                  )),
        );
      },
      child: Container(
        color: const Color(0xff242329),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: REdgeInsets.symmetric(vertical: 10.0),
                  child: CachedNetworkImageWidget(
                    imageUrl: product.mainImgUrl!,
                    borderRadius: BorderRadius.circular(10),
                    height: 60.h,
                    width: 80.w,
                  ),
                ),
                10.verticalSpace,
                SizedBox(
                  width: 165,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      5.verticalSpace,
                      Text(
                        product.subTitle!,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  color: Colors.white,
                  onPressed: () {
                    BlocProvider.of<CartBloc>(context).add(
                      AddProductToCartEvent(
                        CartEntity(
                          productId: product.id,
                          productName: product.productName,
                          price: product.price,
                          cardTotalPrice: product.price,
                          quantity: 1,
                          mainImgUrl: product.mainImgUrl,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add_circle_outline,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
