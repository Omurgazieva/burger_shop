import 'dart:developer';

import '../../../../../core/core.dart';
import '../../../user.dart';

abstract class RemoteProfile {
  Future<UserModel> getUserInfo({required String userID});
  Future<bool> updateUserName({
    required String userId,
    required String userName,
  });
  Future<bool> updateUserPhoto({
    required String userId,
    required String userPhotoUrl,
  });
  // Future<String> getShippingAddresID({required String userID});
  Future<List<ShippingAddressModel>> getAllShippingAddress(
      {required String userId});
  Future<bool> addShippingAddress({
    required ShippingAddressModel newAddress,
  });
  Future<bool> updateShippingAddress(
      {required ShippingAddressModel newAddress});
  Future<bool> selectDefaultShippingAddress({
    required String userId,
    required String addressId,
  });

  Future<List<PaymentCardModel>> getAllPaymentCards({required String userId});
  Future<bool> addNewPaymentCard({
    required PaymentCardModel newPaymentCard,
  });
  Future<bool> selectDefaultPaymentCard({
    required String userId,
    required String paymentCardId,
  });
}

class RemoteProfileImpl implements RemoteProfile {
  final FirestoreCore firestore;
  final LocalAuth localAuth;
  final FirebaseStorageCore storage;

  RemoteProfileImpl({
    required this.firestore,
    required this.localAuth,
    required this.storage,
  });

  @override
  Future<UserModel> getUserInfo({required String userID}) async {
    return await firestore.get(
      docId: userID,
      collectionName: 'users',
      fromJson: authFromJson,
    );
  }

  @override
  Future<bool> updateUserName({
    required String userId,
    required String userName,
  }) async {
    final currentUser = await firestore.get(
      docId: userId,
      collectionName: 'users',
      fromJson: authFromJson,
    );

    UserModel newUser = UserModel(
      userID: currentUser.userID,
      name: userName,
      phoneNumber: currentUser.phoneNumber,
      email: currentUser.email,
      orders: currentUser.orders,
      shippingAddresses: currentUser.shippingAddresses,
      paymentMethods: currentUser.paymentMethods,
      photoURL: currentUser.photoURL,
      role: currentUser.role,
    );

    return getNewUser(currentUser.userID!, newUser);
  }

  @override
  Future<bool> updateUserPhoto({
    required String userId,
    required String userPhotoUrl,
  }) async {
    final userPhotoName = userPhotoUrl.split('/').last;

    final userPhotoImg = await storage.uploadImages(
      collectionName: 'users_photo',
      filePath: userPhotoUrl,
      fileName: userPhotoName,
    );

    final currentUser = await firestore.get(
      docId: userId,
      collectionName: 'users',
      fromJson: authFromJson,
    );

    UserModel newUser = UserModel(
      userID: currentUser.userID,
      name: currentUser.name,
      phoneNumber: currentUser.phoneNumber,
      email: currentUser.email,
      orders: currentUser.orders,
      shippingAddresses: currentUser.shippingAddresses,
      paymentMethods: currentUser.paymentMethods,
      photoURL: userPhotoImg,
      role: currentUser.role,
    );

    return getNewUser(currentUser.userID!, newUser);
  }

  // @override
  // Future<String> getShippingAddresID({
  //   required String userID,
  // }) async {
  //   return await firestore.getDocIdFromSecondCollection(
  //     firstCollectionName: 'users',
  //     secondCollectionName: 'shippingAddress',
  //     firstDocId: userID,
  //   );
  // }

  @override
  Future<List<ShippingAddressModel>> getAllShippingAddress({
    required String userId,
  }) async {
    final user = await firestore.get(
      docId: userId,
      collectionName: 'users',
      fromJson: authFromJson,
    );
    return user.shippingAddresses as List<ShippingAddressModel>;
  }

  Future<bool> getNewUser(String currentUserId, UserModel newUser) async {
    final isUpdated = await firestore.update(
      collectionName: 'users',
      docId: currentUserId,
      objectModel: newUser,
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

  @override
  Future<bool> addShippingAddress({
    required ShippingAddressModel newAddress,
  }) async {
    final currentUser = await firestore.get(
      docId: newAddress.userId!,
      collectionName: 'users',
      fromJson: authFromJson,
    );
    UserModel newUser = FakeLogic().addNewShippingAddress(
      currentUser: currentUser,
      newAddress: newAddress,
    );

    return getNewUser(currentUser.userID!, newUser);
  }

  @override
  Future<bool> updateShippingAddress(
      {required ShippingAddressModel newAddress}) async {
    final currentUser = await firestore.get(
      docId: newAddress.userId!,
      collectionName: 'users',
      fromJson: authFromJson,
    );

    UserModel newUser = FakeLogic().updateShippingAddress(
      currentUser: currentUser,
      newAddress: newAddress,
    );

    return getNewUser(currentUser.userID!, newUser);
  }

  @override
  Future<bool> selectDefaultShippingAddress({
    required String userId,
    required String addressId,
  }) async {
    final currentUser = await firestore.get(
      docId: userId,
      collectionName: 'users',
      fromJson: authFromJson,
    );

    UserModel newUser = FakeLogic().selectDefaultShippingAddress(
      currentUser: currentUser,
      addressId: addressId,
    );

    return getNewUser(currentUser.userID!, newUser);
  }

  @override
  Future<List<PaymentCardModel>> getAllPaymentCards({
    required String userId,
  }) async {
    final user = await firestore.get(
      docId: userId,
      collectionName: 'users',
      fromJson: authFromJson,
    );
    return user.paymentMethods as List<PaymentCardModel>;
  }

  @override
  Future<bool> addNewPaymentCard({
    required PaymentCardModel newPaymentCard,
  }) async {
    final currentUser = await firestore.get(
      docId: newPaymentCard.userId!,
      collectionName: 'users',
      fromJson: authFromJson,
    );

    UserModel newUser = FakeLogic().addNewPaymentCard(
      currentUser: currentUser,
      newCard: newPaymentCard,
    );

    return getNewUser(currentUser.userID!, newUser);
  }

  @override
  Future<bool> selectDefaultPaymentCard({
    required String userId,
    required String paymentCardId,
  }) async {
    final currentUser = await firestore.get(
      docId: userId,
      collectionName: 'users',
      fromJson: authFromJson,
    );

    UserModel newUser = FakeLogic().selectDefaultPaymentCard(
      currentUser: currentUser,
      cardId: paymentCardId,
    );
    return getNewUser(currentUser.userID!, newUser);
  }
}
