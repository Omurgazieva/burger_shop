part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class LoadingBagState extends CartState {}

class ClearedProductCartState extends CartState {}

class LoadedAllProductsFromCartState extends CartState {
  final List<CartEntity> allProducts;
  final double totalAmount;
  const LoadedAllProductsFromCartState(this.allProducts, this.totalAmount);
  @override
  List<Object> get props => [allProducts, totalAmount];
}

class AddedProductToCartState extends CartState {
  final bool isAdded;
  const AddedProductToCartState(this.isAdded);
  @override
  List<Object> get props => [isAdded];
}

class DeletedProductFromCartState extends CartState {
  final bool isDeleted;
  const DeletedProductFromCartState(this.isDeleted);
  @override
  List<Object> get props => [isDeleted];
}

class ProductFromCartExistsState extends CartState {}

class AddedOrderState extends CartState {
  final bool isCreated;
  const AddedOrderState(this.isCreated);
  @override
  List<Object> get props => [isCreated];
}

class NewQuantityState extends CartState {
  final int newQuantity;
  final int newPrice;
  const NewQuantityState(this.newQuantity, this.newPrice);
  @override
  List<Object> get props => [newQuantity, newPrice];
}

class CartFailureState extends CartState {
  final String message;
  const CartFailureState(this.message);
  @override
  List<Object> get props => [message];
}
