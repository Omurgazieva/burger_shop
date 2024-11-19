import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../../lib.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  Future<Either<Failure, void>> signInWithPhoneNumber({
    required BuildContext context,
    required String phoneNumber,
  });

  Future<Either<Failure, UserEntity>> sendSmsCode({
    required String smsCode,
  });

  Future<Either<Failure, UserEntity>> signInWithGoogle();

  Future<Either<Failure, UserEntity>> signInWithFacebook();

  Future<Either<Failure, bool>> signOut();
}
