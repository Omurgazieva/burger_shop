import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/entities.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserEntity>> getUserInfo({required String userId});

  Future<Either<Failure, bool>> updateUserName({
    required String userId,
    required String userName,
  });

  Future<Either<Failure, bool>> updateUserPhoto({
    required String userId,
    required String userPhotoUrl,
  });

  Future<Either<Failure, List<ShippingAddressEntity>>> getAllShippingAddress({
    required String userId,
  });

  Future<Either<Failure, bool>> addShippingAddress({
    required ShippingAddressEntity newAddress,
  });

  Future<Either<Failure, bool>> updateShippingAddress({
    required ShippingAddressEntity newAddress,
  });

  Future<Either<Failure, bool>> selectDefaultShippingAddress({
    required String userId,
    required String addressId,
  });

  Future<Either<Failure, List<PaymentCardEntity>>> getAllPaymentCards({
    required String userId,
  });

  Future<Either<Failure, bool>> addNewPaymentCard({
    required PaymentCardEntity newPaymentCard,
  });

  Future<Either<Failure, bool>> selectDefaultPaymentCard({
    required String userId,
    required String paymentCardId,
  });
}
