import 'dart:convert';

import '../../domain/entities/product_entity.dart';

ProductModel productFromJson(Map docMap) =>
    ProductModel.fromJson(docMap as Map<String, dynamic>);

String productToJson(ProductModel data) => json.encode(data.toJson());

ProductModel productToModel(String id, ProductEntity entity) => ProductModel(
      id: id,
      category: entity.category,
      productName: entity.productName,
      mainTitle: entity.mainTitle,
      subTitle: entity.subTitle,
      productDatailTitle: entity.productDatailTitle,
      price: entity.price,
      description: entity.description,
      mainImgUrl: entity.mainImgUrl,
      datailImgUrl: entity.datailImgUrl,
      createdDate: entity.createdDate,
    );

class ProductModel extends ProductEntity {
  const ProductModel({
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
  }) : super(
          id: id,
          category: category,
          productName: productName,
          mainTitle: mainTitle,
          subTitle: subTitle,
          productDatailTitle: productDatailTitle,
          price: price,
          description: description,
          mainImgUrl: mainImgUrl,
          datailImgUrl: datailImgUrl,
          createdDate: createdDate,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as String,
        category: json['category'] as String,
        productName: json['productName'] as String,
        mainTitle: json['title'] as String,
        subTitle: json['subTitle'] as String,
        productDatailTitle: json['productDatailTitle'] as String,
        price: json['price'] as double,
        description: json['description'] as String,
        mainImgUrl: json['mainImgUrl'] as String,
        datailImgUrl: json['datailImgUrl'] as String,
        createdDate: json['createdDate'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? '',
        "category": category ?? '',
        "productName": productName ?? '',
        "title": mainTitle ?? '',
        "subTitle": subTitle ?? '',
        "productDatailTitle": productDatailTitle ?? '',
        "price": price ?? 0.0,
        "description": description ?? '',
        "mainImgUrl": mainImgUrl ?? '',
        "datailImgUrl": datailImgUrl ?? '',
        "createdDate": createdDate ?? DateTime.now().toString(),
      };
}
