import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String? category;
  final String? productName;
  final String? mainTitle;
  final String? subTitle;
  final String? productDatailTitle;
  final double? price;
  final String? description;
  final String? mainImgUrl;
  final String? datailImgUrl;
  final String? createdDate;

  const ProductEntity({
    this.id,
    this.category,
    this.productName,
    this.mainTitle,
    this.subTitle,
    this.productDatailTitle,
    this.price,
    this.description,
    this.mainImgUrl,
    this.datailImgUrl,
    this.createdDate,
  });

  @override
  List<Object?> get props => [
        id,
        category,
        productName,
        mainTitle,
        subTitle,
        productDatailTitle,
        price,
        description,
        mainImgUrl,
        datailImgUrl,
        createdDate,
      ];
}
