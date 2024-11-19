import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../domain.dart';

class SignInWithGoogle {
  final AuthRepo authRepo;

  SignInWithGoogle(this.authRepo);

  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    return await authRepo.signInWithGoogle();
  }
}
