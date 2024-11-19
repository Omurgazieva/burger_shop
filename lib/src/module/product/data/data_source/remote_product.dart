import 'dart:developer';

import '../../../../core/core.dart';
import '../../../module.dart';

abstract class RemoteProduct {
  Future<List<ProductModel>> getAllProducts();

  Future<String> getProductId();

  Future<bool> addProduct({
    required ProductModel product,
  });

  Future<bool> addOrder({
    required OrderModel order,
  });

  Future<String> getOrderId();
}

class RemoteProductImpl implements RemoteProduct {
  final FirestoreCore firestore;
  final LocalAuth localAuth;

  RemoteProductImpl({
    required this.firestore,
    required this.localAuth,
  });

  @override
  Future<List<ProductModel>> getAllProducts() async {
    return await firestore.getList(
      collectionName: 'products',
      fromJson: productFromJson,
    );
  }

  @override
  Future<String> getProductId() async {
    return await firestore.getId(
      collectionName: 'products',
    );
  }

  @override
  Future<bool> addProduct({
    required ProductModel product,
  }) async {
    return await firestore.create(
      docId: product.id!,
      objectModel: product,
      collectionName: 'products',
    );
  }

  @override
  Future<String> getOrderId() async {
    return await firestore.getId(
      collectionName: 'orders',
    );
  }

  @override
  Future<bool> addOrder({
    required OrderModel order,
  }) async {
    final user = await firestore.get(
      docId: order.userID!,
      collectionName: 'users',
      fromJson: authFromJson,
    );

    List<OrderModel> ordersList = [];
    ordersList = user.orders as List<OrderModel>;
    ordersList.add(order);

    final isAddedToOrders = await firestore.create(
      docId: order.id!,
      objectModel: order,
      collectionName: 'orders',
    );

    UserModel newUser = UserModel(
      userID: user.userID,
      name: user.name,
      phoneNumber: user.phoneNumber,
      email: user.email,
      orders: ordersList,
      shippingAddresses: user.shippingAddresses,
      paymentMethods: user.paymentMethods,
      photoURL: user.photoURL,
      role: user.role,
    );

    final isUpdated = await firestore.update(
      docId: user.userID!,
      objectModel: newUser,
      collectionName: 'users',
    );

    if (isUpdated) {
      localAuth.clearCache();
      localAuth.addUserToCache(newUser);
      log('cach ====>>>>>   new user saved to cache');
      return true;
    } else {
      return false;
    }
  }
}
