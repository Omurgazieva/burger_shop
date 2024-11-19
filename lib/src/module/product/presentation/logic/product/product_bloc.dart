import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;
  final AddProduct addProduct;
  ProductBloc({
    required this.getAllProducts,
    required this.addProduct,
  }) : super(LoadingProductsState()) {
    on<GetAllProductsEvent>(_getAllProducts);
    on<AddProductEvent>(_addProduct);
  }

  void _getAllProducts(
      GetAllProductsEvent event, Emitter<ProductState> emit) async {
    emit(LoadingProductsState());
    final allProducts = await getAllProducts.getAllProducts();
    allProducts.fold(
      (error) => emit(ProductFailureState(error)),
      (allProducts) => emit(LoadedProductsState(allProducts)),
    );
  }

  void _addProduct(AddProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingProductsState());
    final isCreated =
        await addProduct(AddProductParams(product: event.product));
    isCreated.fold(
      (error) => emit(ProductFailureState(error)),
      (isCreated) => emit(AddedProductState(isCreated)),
    );
  }
}
