part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class LoadingProductsState extends ProductState {}

class LoadedProductsState extends ProductState {
  final List<ProductEntity> allProducts;
  const LoadedProductsState(this.allProducts);
  @override
  List<Object> get props => [allProducts];
}

class AddedProductState extends ProductState {
  final bool isCreated;
  const AddedProductState(this.isCreated);
  @override
  List<Object> get props => [isCreated];
}

class ProductFailureState extends ProductState {
  final Failure message;
  const ProductFailureState(this.message);
  @override
  List<Object> get props => [message];
}
