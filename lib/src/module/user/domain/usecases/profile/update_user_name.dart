import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../user.dart';

class UpdateUserName extends UseCase<bool, UpdateUserNameParams> {
  final ProfileRepo profileRepo;
  UpdateUserName(this.profileRepo);

  @override
  Future<Either<Failure, bool>> call(UpdateUserNameParams params) async {
    return await profileRepo.updateUserName(
      userId: params.userId,
      userName: params.userName,
    );
  }
}

class UpdateUserNameParams extends Equatable {
  final String userId;
  final String userName;
  const UpdateUserNameParams({
    required this.userId,
    required this.userName,
  });

  @override
  List<Object?> get props => [
        userId,
        userName,
      ];
}
