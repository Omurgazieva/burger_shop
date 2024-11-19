import '../../module/user/user.dart';

class FakeLogic {
  UserModel selectDefaultPaymentCard({
    required UserModel currentUser,
    required String cardId,
  }) {
    List<PaymentCardModel> paymentCards = [];
    paymentCards = currentUser.paymentMethods as List<PaymentCardModel>;
    for (PaymentCardModel e in paymentCards) {
      e.isCheked = false;
      if (e.id == cardId) {
        e.isCheked = true;
      }
    }
    return UserModel(
      userID: currentUser.userID,
      name: currentUser.name,
      phoneNumber: currentUser.phoneNumber,
      email: currentUser.email,
      orders: currentUser.orders,
      shippingAddresses: currentUser.shippingAddresses,
      paymentMethods: paymentCards,
      photoURL: currentUser.photoURL,
      role: currentUser.role,
    );
  }

  UserModel addNewPaymentCard({
    required UserModel currentUser,
    required PaymentCardModel newCard,
  }) {
    List<PaymentCardModel> paymentCards = [];
    paymentCards = currentUser.paymentMethods as List<PaymentCardModel>;
    for (PaymentCardModel e in paymentCards) {
      if (newCard.isCheked == true) {
        e.isCheked = false;
      }
    }
    paymentCards.add(newCard);

    return UserModel(
      userID: currentUser.userID,
      name: currentUser.name,
      phoneNumber: currentUser.phoneNumber,
      email: currentUser.email,
      orders: currentUser.orders,
      shippingAddresses: currentUser.shippingAddresses,
      paymentMethods: paymentCards,
      photoURL: currentUser.photoURL,
      role: currentUser.role,
    );
  }

  UserModel selectDefaultShippingAddress({
    required UserModel currentUser,
    required String addressId,
  }) {
    List<ShippingAddressModel> addressList = [];
    addressList = currentUser.shippingAddresses as List<ShippingAddressModel>;
    for (ShippingAddressModel e in addressList) {
      e.isCheked = false;
      if (e.id == addressId) {
        e.isCheked = true;
      }
    }
    return UserModel(
      userID: currentUser.userID,
      name: currentUser.name,
      phoneNumber: currentUser.phoneNumber,
      email: currentUser.email,
      orders: currentUser.orders,
      shippingAddresses: addressList,
      paymentMethods: currentUser.paymentMethods,
      photoURL: currentUser.photoURL,
      role: currentUser.role,
    );
  }

  UserModel updateShippingAddress({
    required UserModel currentUser,
    required ShippingAddressModel newAddress,
  }) {
    List<ShippingAddressModel> addressList = [];
    addressList = currentUser.shippingAddresses as List<ShippingAddressModel>;
    for (ShippingAddressModel e in addressList) {
      if (newAddress.isCheked == true) {
        e.isCheked = false;
      }
    }
    addressList.removeWhere((e) => e.id == newAddress.id);
    addressList.add(newAddress);

    return UserModel(
      userID: currentUser.userID,
      name: currentUser.name,
      phoneNumber: currentUser.phoneNumber,
      email: currentUser.email,
      orders: currentUser.orders,
      shippingAddresses: addressList,
      paymentMethods: currentUser.paymentMethods,
      photoURL: currentUser.photoURL,
      role: currentUser.role,
    );
  }

  UserModel addNewShippingAddress({
    required UserModel currentUser,
    required ShippingAddressModel newAddress,
  }) {
    List<ShippingAddressModel> addressList = [];
    addressList = currentUser.shippingAddresses as List<ShippingAddressModel>;
    for (ShippingAddressModel e in addressList) {
      if (newAddress.isCheked == true) {
        e.isCheked = false;
      }
    }
    addressList.add(newAddress);

    return UserModel(
      userID: currentUser.userID,
      name: currentUser.name,
      phoneNumber: currentUser.phoneNumber,
      email: currentUser.email,
      orders: currentUser.orders,
      shippingAddresses: addressList,
      paymentMethods: currentUser.paymentMethods,
      photoURL: currentUser.photoURL,
      role: currentUser.role,
    );
  }
}
