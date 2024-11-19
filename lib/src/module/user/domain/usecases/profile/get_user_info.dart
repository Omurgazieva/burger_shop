import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../user.dart';

class GetUserInfo extends UseCase<UserEntity, GetUserInfoParams> {
  final ProfileRepo profileRepo;
  GetUserInfo(this.profileRepo);

  @override
  Future<Either<Failure, UserEntity>> call(GetUserInfoParams params) async {
    return await profileRepo.getUserInfo(userId: params.userId);
  }
}

class GetUserInfoParams extends Equatable {
  final String userId;
  const GetUserInfoParams({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}
