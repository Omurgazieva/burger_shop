import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../user.dart';

class AddShippingAddress extends UseCase<bool, AddShippingAddressParams> {
  final ProfileRepo profileRepo;
  AddShippingAddress(this.profileRepo);

  @override
  Future<Either<Failure, bool>> call(AddShippingAddressParams params) async {
    return await profileRepo.addShippingAddress(newAddress: params.address);
  }
}

class AddShippingAddressParams extends Equatable {
  final ShippingAddressEntity address;
  const AddShippingAddressParams({
    required this.address,
  });

  @override
  List<Object?> get props => [address];
}
