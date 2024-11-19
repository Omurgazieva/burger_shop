import 'package:burger_shop/src/module/product/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({required this.productList, super.key});

  final List<ProductEntity> productList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 40.h,
        mainAxisSpacing: 10.h,
        crossAxisCount: 2,
        childAspectRatio: 90.h / 115.h,
      ),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return ProductCard(
          product: product,
        );
      },
    );
  }
}
