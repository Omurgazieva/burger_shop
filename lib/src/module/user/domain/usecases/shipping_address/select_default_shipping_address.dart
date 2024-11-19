import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../user.dart';

class SelectDefaultShippingAddress
    extends UseCase<bool, SelectDefaultAddressParams> {
  final ProfileRepo profileRepo;
  SelectDefaultShippingAddress(this.profileRepo);

  @override
  Future<Either<Failure, bool>> call(SelectDefaultAddressParams params) async {
    return await profileRepo.selectDefaultShippingAddress(
      userId: params.userId,
      addressId: params.addressId,
    );
  }
}

class SelectDefaultAddressParams extends Equatable {
  final String userId;
  final String addressId;
  const SelectDefaultAddressParams({
    required this.userId,
    required this.addressId,
  });

  @override
  List<Object?> get props => [userId, addressId];
}
