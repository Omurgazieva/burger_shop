part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class ClearProductCartEvent extends CartEvent {}

class AddProductToCartEvent extends CartEvent {
  final CartEntity product;

  const AddProductToCartEvent(this.product);
}

class GetAllProductFromCartEvent extends CartEvent {}

class DeleteProductFromCartEvent extends CartEvent {
  final String productID;

  const DeleteProductFromCartEvent(this.productID);
}

class AddNewQuantityEvent extends CartEvent {
  final CartEntity product;

  const AddNewQuantityEvent(this.product);
}

class AddOrderEvent extends CartEvent {
  final OrderEntity order;

  const AddOrderEvent(this.order);
}
