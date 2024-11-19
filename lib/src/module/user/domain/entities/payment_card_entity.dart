import 'package:equatable/equatable.dart';

class PaymentCardEntity extends Equatable {
  final String? id;
  final String? userId;
  final String? name;
  final CardType? type;
  final String? cardNumber;
  final int? month;
  final int? year;
  final int? cvv;
  bool? isCheked;
  final String? createdDate;

  PaymentCardEntity({
    this.id,
    this.userId,
    this.name,
    this.type,
    this.cardNumber,
    this.month,
    this.year,
    this.cvv,
    this.isCheked,
    this.createdDate,
  });

  @override
  List<Object?> get props => [
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
      ];
}

enum CardType {
  master,
  visa,
  verve,
  discover,
  americanExpress,
  dinersClub,
  jcb,
  others,
  invalid
}
