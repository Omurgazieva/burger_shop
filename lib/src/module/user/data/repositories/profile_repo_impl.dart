import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../user.dart';

class ProfileRepoImpl implements ProfileRepo {
  ProfileRepoImpl({
    required this.remoteProfile,
  });

  final RemoteProfile remoteProfile;

  @override
  Future<Either<Failure, UserEntity>> getUserInfo({
    required String userId,
  }) async {
    try {
      final userInfo = await remoteProfile.getUserInfo(userID: userId);
      return Right(userInfo);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserName({
    required String userId,
    required String userName,
  }) async {
    try {
      final isUpdated = await remoteProfile.updateUserName(
        userId: userId,
        userName: userName,
      );
      return Right(isUpdated);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserPhoto({
    required String userId,
    required String userPhotoUrl,
  }) async {
    try {
      final isUpdated = await remoteProfile.updateUserPhoto(
        userId: userId,
        userPhotoUrl: userPhotoUrl,
      );
      return Right(isUpdated);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addShippingAddress(
      {required ShippingAddressEntity newAddress}) async {
    try {
      final isCreated = await remoteProfile.addShippingAddress(
        newAddress: shippingAddressToModel(newAddress.id!, newAddress),
      );
      return Right(isCreated);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ShippingAddressEntity>>> getAllShippingAddress({
    required String userId,
  }) async {
    try {
      final allShippingaddress = await remoteProfile.getAllShippingAddress(
        userId: userId,
      );
      return Right(allShippingaddress);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateShippingAddress(
      {required ShippingAddressEntity newAddress}) async {
    try {
      final isUpdated = await remoteProfile.updateShippingAddress(
        newAddress: shippingAddressToModel(newAddress.id!, newAddress),
      );
      return Right(isUpdated);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> selectDefaultShippingAddress({
    required String userId,
    required String addressId,
  }) async {
    try {
      final isSelected = await remoteProfile.selectDefaultShippingAddress(
        userId: userId,
        addressId: addressId,
      );
      return Right(isSelected);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PaymentCardEntity>>> getAllPaymentCards({
    required String userId,
  }) async {
    try {
      final allPaymentCards = await remoteProfile.getAllPaymentCards(
        userId: userId,
      );
      return Right(allPaymentCards);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addNewPaymentCard(
      {required PaymentCardEntity newPaymentCard}) async {
    try {
      final isCreated = await remoteProfile.addNewPaymentCard(
        newPaymentCard: paymentCardToModel(newPaymentCard.id!, newPaymentCard),
      );
      return Right(isCreated);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> selectDefaultPaymentCard({
    required String userId,
    required String paymentCardId,
  }) async {
    try {
      final isSelected = await remoteProfile.selectDefaultPaymentCard(
        userId: userId,
        paymentCardId: paymentCardId,
      );
      return Right(isSelected);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
