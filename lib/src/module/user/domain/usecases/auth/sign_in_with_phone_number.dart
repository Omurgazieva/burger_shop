import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../domain.dart';

class SignInWithPhoneNumber extends UseCase<void, SignInWithPhoneNumberParams> {
  final AuthRepo authRepo;
  SignInWithPhoneNumber(this.authRepo);

  @override
  Future<Either<Failure, void>> call(SignInWithPhoneNumberParams params) async {
    return await authRepo.signInWithPhoneNumber(
      context: params.context,
      phoneNumber: params.phoneNumber,
    );
  }
}

class SignInWithPhoneNumberParams extends Equatable {
  final String phoneNumber;
  final BuildContext context;
  const SignInWithPhoneNumberParams(
      {required this.context, required this.phoneNumber});

  @override
  List<Object?> get props => [
        phoneNumber,
        context,
      ];
}
