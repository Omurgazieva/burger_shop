import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../domain.dart';

class GetCurrentUser {
  final AuthRepo authRepo;
  GetCurrentUser(this.authRepo);

  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    return await authRepo.getCurrentUser();
  }
}
