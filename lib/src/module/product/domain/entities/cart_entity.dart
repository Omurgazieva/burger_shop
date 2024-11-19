import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final String? id;
  final String? productId;
  final String? productName;
  final double? price;
  final int? quantity;
  final double? cardTotalPrice;
  final String? mainImgUrl;

  const CartEntity({
    this.id,
    this.productId,
    this.productName,
    this.price,
    this.quantity,
    this.cardTotalPrice,
    this.mainImgUrl,
  });

  @override
  List<Object?> get props => [
        id,
        productId,
        productName,
        price,
        quantity,
        cardTotalPrice,
        mainImgUrl,
      ];
}
