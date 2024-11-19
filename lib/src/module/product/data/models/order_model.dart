import 'dart:convert';

import '../../product.dart';
import '../../../user/user.dart';

OrderModel ordersFromJson(Map docMap) =>
    OrderModel.fromJson(docMap as Map<String, dynamic>);

String orderstToJson(OrderModel data) => json.encode(data.toJson());

OrderModel orderToModel(String id, OrderEntity entity) => OrderModel(
      id: id,
      userID: entity.userID,
      userName: entity.userName,
      orderNumber: entity.orderNumber,
      trackingNumber: entity.trackingNumber,
      status: entity.status,
      items: entity.items,
      shippingAddress: entity.shippingAddress,
      paymentMethod: entity.paymentMethod,
      deliveryMethod: entity.deliveryMethod,
      totalAmount: entity.totalAmount,
      createdDate: entity.createdDate,
    );

class OrderModel extends OrderEntity {
  const OrderModel({
    id,
    userID,
    userName,
    orderNumber,
    trackingNumber,
    status,
    items,
    shippingAddress,
    paymentMethod,
    deliveryMethod,
    totalAmount,
    createdDate,
  }) : super(
          id: id,
          userID: userID,
          userName: userName,
          orderNumber: orderNumber,
          trackingNumber: trackingNumber,
          status: status,
          items: items,
          shippingAddress: shippingAddress,
          paymentMethod: paymentMethod,
          deliveryMethod: deliveryMethod,
          totalAmount: totalAmount,
          createdDate: createdDate,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'] as String,
        userID: json['userID'] as String,
        userName: json['userName'] as String,
        orderNumber: json['orderNumber'] as int,
        trackingNumber: json['trackingNumber'] as String,
        status: json['status'] as String,
        items: (json['items'] as List<dynamic>)
            .map((e) => CartModel.fromJson(e))
            .toList(),
        shippingAddress: json['shippingAddress'] != null
            ? ShippingAddressModel.fromJson(json['shippingAddress'])
            : ShippingAddressModel(),
        paymentMethod: json['paymentMethod'] != null
            ? PaymentCardModel.fromJson(json['paymentMethod'])
            : PaymentCardModel(),
        deliveryMethod: json['deliveryMethod'] as String,
        totalAmount: json['totalAmount'] as double,
        createdDate: json['createdDate'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? '',
        "userID": userID ?? '',
        "userName": userName ?? '',
        "orderNumber": orderNumber ?? 0,
        "trackingNumber": trackingNumber ?? '',
        "status": status ?? 'processing',
        "items": items!
            .map((item) => CartModel(
                  productId: item.productId,
                  productName: item.productName,
                  price: item.price,
                  quantity: item.quantity,
                  cardTotalPrice: item.cardTotalPrice,
                  mainImgUrl: item.mainImgUrl,
                ).toJson())
            .toList(),
        "shippingAddress": ShippingAddressModel(
          id: shippingAddress!.id,
          userId: shippingAddress!.userId,
          userName: shippingAddress!.userName,
          address: shippingAddress!.address,
          city: shippingAddress!.city,
          country: shippingAddress!.country,
          isCheked: shippingAddress!.isCheked,
        ).toJson(),
        "paymentMethod": PaymentCardModel(
          id: id,
          userId: paymentMethod!.userId,
          name: paymentMethod!.name,
          cardNumber: paymentMethod!.cardNumber,
          month: paymentMethod!.month,
          year: paymentMethod!.year,
          cvv: paymentMethod!.cvv,
          isCheked: paymentMethod!.isCheked,
          createdDate: paymentMethod!.createdDate,
        ).toJson(),
        "deliveryMethod": deliveryMethod ?? '',
        "totalAmount": totalAmount ?? 0.0,
        "createdDate": createdDate ?? DateTime.now().toString(),
      };
}
