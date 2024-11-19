import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../user.dart';

class AddNewPaymentCard extends UseCase<bool, AddPaymentCardParams> {
  final ProfileRepo profileRepo;
  AddNewPaymentCard(this.profileRepo);

  @override
  Future<Either<Failure, bool>> call(AddPaymentCardParams params) async {
    return await profileRepo.addNewPaymentCard(
        newPaymentCard: params.newPaymentCard);
  }
}

class AddPaymentCardParams extends Equatable {
  final PaymentCardEntity newPaymentCard;
  const AddPaymentCardParams({
    required this.newPaymentCard,
  });

  @override
  List<Object?> get props => [newPaymentCard];
}
