import 'dart:convert';

import 'package:burger_shop/src/core/core.dart';

import '../../user.dart';

PaymentCardModel cardFromJson(Map docMap) =>
    PaymentCardModel.fromJson(docMap as Map<String, dynamic>);

String cardToJson(PaymentCardModel data) => json.encode(data.toJson());

PaymentCardModel paymentCardToModel(String id, PaymentCardEntity entity) =>
    PaymentCardModel(
      id: id,
      userId: entity.userId,
      name: entity.name,
      type: entity.type,
      cardNumber: entity.cardNumber,
      month: entity.month,
      year: entity.year,
      cvv: entity.cvv,
      isCheked: entity.isCheked,
      createdDate: entity.createdDate,
    );

class PaymentCardModel extends PaymentCardEntity {
  PaymentCardModel({
    id,
    userId,
    name,
    type,
    cardNumber,
    month,
    year,
    cvv,
    isCheked,
    createdDate,
  }) : super(
          id: id,
          userId: userId,
          name: name,
          type: type,
          cardNumber: cardNumber,
          month: month,
          year: year,
          cvv: cvv,
          isCheked: isCheked,
          createdDate: createdDate,
        );

  factory PaymentCardModel.fromJson(Map<String, dynamic> json) =>
      PaymentCardModel(
        id: json['id'] as String,
        userId: json['userId'] as String,
        name: json['name'] as String,
        type: CardUtils.getCardTypeFrmNumber(json['cardNumber'] as String),
        cardNumber: json['cardNumber'] as String,
        month: json['month'] as int,
        year: json['year'] as int,
        cvv: json['cvv'] as int,
        isCheked: json['isCheked'] as bool,
        createdDate: json['createdDate'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? '',
        "userId": userId ?? '',
        "name": name ?? '',
        "cardNumber": cardNumber ?? '',
        "month": month ?? 0,
        "year": year ?? 0,
        "cvv": cvv ?? 0,
        "isCheked": isCheked ?? false,
        "createdDate": createdDate ?? DateTime.now().toString(),
      };
}
