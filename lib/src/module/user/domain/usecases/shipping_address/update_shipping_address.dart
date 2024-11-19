import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../user.dart';

class UpdateShippingAddress extends UseCase<bool, UpdateShippngAddressParams> {
  final ProfileRepo profileRepo;
  UpdateShippingAddress(this.profileRepo);

  @override
  Future<Either<Failure, bool>> call(UpdateShippngAddressParams params) async {
    return await profileRepo.updateShippingAddress(newAddress: params.address);
  }
}

class UpdateShippngAddressParams extends Equatable {
  final ShippingAddressEntity address;
  const UpdateShippngAddressParams({
    required this.address,
  });

  @override
  List<Object?> get props => [address];
}
