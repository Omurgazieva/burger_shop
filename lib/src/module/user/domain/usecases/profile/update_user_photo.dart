import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../user.dart';

class UpdateUserPhoto extends UseCase<bool, UpdateUserPhotoParams> {
  final ProfileRepo profileRepo;
  UpdateUserPhoto(this.profileRepo);

  @override
  Future<Either<Failure, bool>> call(UpdateUserPhotoParams params) async {
    return await profileRepo.updateUserPhoto(
      userId: params.userId,
      userPhotoUrl: params.userPhotoUrl,
    );
  }
}

class UpdateUserPhotoParams extends Equatable {
  final String userId;
  final String userPhotoUrl;
  const UpdateUserPhotoParams({
    required this.userId,
    required this.userPhotoUrl,
  });

  @override
  List<Object?> get props => [
        userId,
        userPhotoUrl,
      ];
}
