import 'dart:convert';

import '../../user.dart';

DeliveryModel deliveryFromJson(Map docMap) =>
    DeliveryModel.fromJson(docMap as Map<String, dynamic>);

String deliveryToJson(DeliveryModel data) => json.encode(data.toJson());

DeliveryModel deliveryToModel(String id, DeliveryEntity entity) =>
    DeliveryModel(
      id: id,
      name: entity.name,
      days: entity.days,
      price: entity.price,
      image: entity.image,
    );

class DeliveryModel extends DeliveryEntity {
  const DeliveryModel({
    id,
    name,
    days,
    price,
    image,
  }) : super(
          id: id,
          name: name,
          days: days,
          price: price,
          image: image,
        );

  factory DeliveryModel.fromJson(Map<String, dynamic> json) => DeliveryModel(
        id: json['id'] as String,
        name: json['name'] as String,
        days: json['days'] as int,
        price: json['price'] as double,
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? '',
        "name": name ?? '',
        "days": days ?? 0,
        "price": price ?? 0.0,
      };
}
