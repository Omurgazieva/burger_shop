import 'dart:convert';

import '../../../../../lib.dart';

CartModel cartProductFromJson(Map docMap) =>
    CartModel.fromJson(docMap as Map<String, dynamic>);

String cartProductToJson(CartModel data) => json.encode(data.toJson());

CartModel cartToModel(String id, CartEntity entity) => CartModel(
      productId: entity.productId,
      productName: entity.productName,
      price: entity.price,
      quantity: entity.quantity,
      cardTotalPrice: entity.cardTotalPrice,
      mainImgUrl: entity.mainImgUrl,
    );

class CartModel extends CartEntity {
  const CartModel({
    id,
    productId,
    productName,
    price,
    quantity,
    cardTotalPrice,
    mainImgUrl,
  }) : super(
          id: id,
          productId: productId,
          productName: productName,
          price: price,
          quantity: quantity,
          cardTotalPrice: cardTotalPrice,
          mainImgUrl: mainImgUrl,
        );

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json['id'] as String,
        productId: json['productId'] as String,
        productName: json['productName'] as String,
        price: json['price'] as double,
        quantity: json['quantity'] as int,
        cardTotalPrice: json['cardTotalPrice'] as double,
        mainImgUrl: json['mainImgUrl'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? '',
        "productId": productId ?? '',
        "productName": productName ?? '',
        "price": price ?? 0.0,
        "quantity": quantity ?? 1,
        "cardTotalPrice": cardTotalPrice ?? 0.0,
        "mainImgUrl": mainImgUrl ?? '',
      };
}
