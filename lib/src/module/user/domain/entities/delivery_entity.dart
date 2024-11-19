import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DeliveryEntity extends Equatable {
  final String? id;
  final String? name;
  final int? days;
  final double? price;
  final Image? image;

  const DeliveryEntity({
    this.id,
    this.name,
    this.days,
    this.price,
    this.image,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        days,
        price,
        image,
      ];
}
