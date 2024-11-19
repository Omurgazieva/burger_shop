import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit()
      : super(const CounterState(
          quantity: 1,
          cardTotalPrice: 0,
        ));
  int _quantity = 1;
  double _totalCardPrice = 0;

  void getPrise(
    double pricePerUnit,
    int newQuantity,
  ) {
    _quantity = newQuantity;
    _totalCardPrice = pricePerUnit;
    emit(CounterState(
      quantity: _quantity,
      cardTotalPrice: pricePerUnit,
    ));
  }

  void increment(
    double pricePerUnit,
  ) {
    _quantity++;
    _totalCardPrice = pricePerUnit * _quantity;
    emit(CounterState(
      quantity: _quantity,
      cardTotalPrice: _totalCardPrice,
    ));
  }

  void decrement(
    double pricePerUnit,
  ) {
    if (state.quantity > 1) {
      _quantity--;
      _totalCardPrice = pricePerUnit * _quantity;
      emit(CounterState(
        quantity: _quantity,
        cardTotalPrice: _totalCardPrice,
      ));
    }
  }
}
