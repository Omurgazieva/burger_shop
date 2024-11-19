import 'package:equatable/equatable.dart';

class ShippingAddressEntity extends Equatable {
  final String? id;
  final String? userId;
  final String? userName;
  final String? address;
  final String? city;
  // final String? region;
  final String? country;
  bool? isCheked;

  ShippingAddressEntity({
    this.id,
    this.userId,
    this.userName,
    this.address,
    this.city,
    // this.region,
    this.country,
    this.isCheked,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        address,
        city,
        // region,
        country,
        isCheked,
      ];
}
