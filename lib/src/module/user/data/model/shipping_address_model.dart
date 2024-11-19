import 'dart:convert';

import '../../user.dart';

ShippingAddressModel addressFromJson(Map docMap) =>
    ShippingAddressModel.fromJson(docMap as Map<String, dynamic>);

String addressToJson(ShippingAddressModel data) => json.encode(data.toJson());

ShippingAddressModel shippingAddressToModel(
        String id, ShippingAddressEntity entity) =>
    ShippingAddressModel(
      id: id,
      userId: entity.userId,
      userName: entity.userName,
      address: entity.address,
      city: entity.city,
      country: entity.country,
      isCheked: entity.isCheked,
    );

class ShippingAddressModel extends ShippingAddressEntity {
  ShippingAddressModel({
    id,
    userId,
    userName,
    address,
    city,
    country,
    isCheked,
  }) : super(
          id: id,
          userId: userId,
          userName: userName,
          address: address,
          city: city,
          country: country,
          isCheked: isCheked,
        );

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) =>
      ShippingAddressModel(
        id: json['id'] as String,
        userId: json['userId'] as String,
        userName: json['userName'] as String,
        address: json['address'] as String,
        city: json['city'] as String,
        country: json['country'] as String,
        isCheked: json['isCheked'] as bool,
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? '',
        "userId": userId ?? '',
        "userName": userName ?? '',
        "address": address ?? '',
        "city": city ?? '',
        "country": country ?? '',
        "isCheked": isCheked ?? false,
      };
}
