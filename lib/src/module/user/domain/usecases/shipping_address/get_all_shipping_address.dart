import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../user.dart';

class GetAllShippingAddress
    extends UseCase<List<ShippingAddressEntity>, GetAllShippingAddressParams> {
  final ProfileRepo profileRepo;
  GetAllShippingAddress(this.profileRepo);

  @override
  Future<Either<Failure, List<ShippingAddressEntity>>> call(
      GetAllShippingAddressParams params) async {
    return await profileRepo.getAllShippingAddress(
      userId: params.userId,
    );
  }
}

class GetAllShippingAddressParams extends Equatable {
  final String userId;
  const GetAllShippingAddressParams({
    required this.userId,
  });

  @override
  List<Object?> get props => [
        userId,
      ];
}
