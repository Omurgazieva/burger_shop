import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../domain.dart';

class SignOut {
  final AuthRepo authRepo;
  SignOut(this.authRepo);

  Future<Either<Failure, bool?>> signOut() async {
    return await authRepo.signOut();
  }
}
