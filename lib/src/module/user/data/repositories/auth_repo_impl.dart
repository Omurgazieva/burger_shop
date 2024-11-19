import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../user.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({
    required this.remoteAuth,
    required this.localAuth,
  });

  final FirebaseAutData remoteAuth;
  final LocalAuth localAuth;

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final userFromCache = localAuth.getUserFromCache();

      if (userFromCache != null) {
        log('Current User =====>>>>> _userFromCache');
        return Right(userFromCache);
      } else {
        final userFromServer = await remoteAuth.getCurrentUser();
        if (userFromServer != null) {
          log('Current User =====>>>>> userFromServer');
          localAuth.addUserToCache(userFromServer);
          log('cach ====>>>>>   user saved to cache');

          return Right(userFromServer);
        }
      }
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithPhoneNumber({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      return Right(
        remoteAuth.signInWithPhoneNumber(
          context: context,
          phoneNumber: phoneNumber,
        ),
      );
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> sendSmsCode({
    required String? smsCode,
  }) async {
    try {
      final currentUser = await remoteAuth.validateOtp(smsCode: smsCode!);
      final isExists = await remoteAuth.checkUserExistsFromForestore(
          userId: currentUser.user!.uid);
      if (!isExists) {
        await remoteAuth.createUserToFirestore(user: currentUser.user!);
      }
      final userFromFirestore = await remoteAuth.getUserFromForestore(
        userId: currentUser.user!.uid,
      );
      localAuth.addUserToCache(userFromFirestore);
      log('cach ====>>>>>   user saved to cache');
      return Right(userFromFirestore);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final currentUser = await remoteAuth.signInWithGoogle();
      localAuth.addUserToCache(currentUser);
      log('cach ====>>>>>   user saved to cache');
      return Right(currentUser);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      await remoteAuth.signOut();
      await localAuth.clearCache();
      log('cach =====>>>>>   cach cleared');
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }
}
