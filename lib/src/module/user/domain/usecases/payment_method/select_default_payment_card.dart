import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../user.dart';

class SelectDefaultPaymentCard extends UseCase<bool, SelectDefaultCardParams> {
  final ProfileRepo profileRepo;
  SelectDefaultPaymentCard(this.profileRepo);

  @override
  Future<Either<Failure, bool>> call(SelectDefaultCardParams params) async {
    return await profileRepo.selectDefaultPaymentCard(
      userId: params.userId,
      paymentCardId: params.paymentCardId,
    );
  }
}

class SelectDefaultCardParams extends Equatable {
  final String userId;
  final String paymentCardId;
  const SelectDefaultCardParams({
    required this.userId,
    required this.paymentCardId,
  });

  @override
  List<Object?> get props => [userId, paymentCardId];
}
