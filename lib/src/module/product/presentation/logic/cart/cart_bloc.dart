import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddOrder addOrder;
  CartBloc({
    required this.addOrder,
  }) : super(LoadingBagState()) {
    on<AddProductToCartEvent>(_addProductToCart);
    on<GetAllProductFromCartEvent>(_getAllProductFromCart);
    on<DeleteProductFromCartEvent>(_deleteProductFromCart);
    on<AddNewQuantityEvent>(_addNewQuantity);
    on<AddOrderEvent>(_addOrder);
    on<ClearProductCartEvent>(_clearProductCart);
  }

  List<CartEntity> bagProductList = [];

  void _addProductToCart(
      AddProductToCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingBagState());
    if (bagProductList.isEmpty) {
      bagProductList.add(event.product);
      emit(const AddedProductToCartState(true));
    } else {
      bool isExists = false;
      for (CartEntity e in bagProductList) {
        if (e.productId == event.product.productId) {
          isExists = true;
        }
      }
      if (isExists) {
        emit(ProductFromCartExistsState());
      } else {
        bagProductList.add(event.product);
        emit(const AddedProductToCartState(true));
      }
    }
  }

  void _getAllProductFromCart(
      GetAllProductFromCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingBagState());
    double totalAmount = bagProductList.fold(
      0,
      (total, current) => total + current.cardTotalPrice!,
    );
    emit(LoadedAllProductsFromCartState(
      bagProductList,
      totalAmount,
    ));
  }

  void _deleteProductFromCart(
      DeleteProductFromCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingBagState());
    bagProductList.removeWhere((e) => e.productId == event.productID);
    emit(const DeletedProductFromCartState(true));
  }

  void _addNewQuantity(
      AddNewQuantityEvent event, Emitter<CartState> emit) async {
    bagProductList[bagProductList.indexWhere(
        (e) => e.productId == event.product.productId)] = event.product;
    double totalAmount = bagProductList.fold(
      0,
      (total, current) => total + current.cardTotalPrice!,
    );
    emit(LoadedAllProductsFromCartState(
      bagProductList,
      totalAmount,
    ));
  }

  void _addOrder(AddOrderEvent event, Emitter<CartState> emit) async {
    emit(LoadingBagState());
    final isCreated = await addOrder(AddOrderParams(
      order: event.order,
    ));
    isCreated.fold((error) => emit(const CartFailureState('')),
        (isCreated) => emit(AddedOrderState(isCreated)));
  }

  void _clearProductCart(
      ClearProductCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingBagState());
    bagProductList = [];
    emit(ClearedProductCartState());
  }
}
