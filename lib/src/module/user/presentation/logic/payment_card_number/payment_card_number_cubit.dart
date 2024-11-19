import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:burger_shop/src/core/core.dart';

import '../../../user.dart';

part 'payment_card_number_state.dart';

class PaymentCardNumberCubit extends Cubit<PaymentCardNumberState> {
  PaymentCardNumberCubit()
      : super(const PaymentCardNumberState(CardType.others, ''));

  getCardTypeFrmNumber(String input) {
    final cardType = CardUtils.getCardTypeFrmNumber(input);
    log('cardType ===>>>> $cardType');
    emit(PaymentCardNumberState(cardType, ''));
  }
}
