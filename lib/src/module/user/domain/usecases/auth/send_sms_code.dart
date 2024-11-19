import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../domain.dart';

class SendSmsCode extends UseCase<UserEntity, SmsCodeParams> {
  final AuthRepo authRepo;
  SendSmsCode(this.authRepo);

  @override
  Future<Either<Failure, UserEntity>> call(SmsCodeParams params) async {
    return await authRepo.sendSmsCode(
      smsCode: params.smsCode,
    );
  }
}

class SmsCodeParams extends Equatable {
  final String smsCode;
  const SmsCodeParams({required this.smsCode});

  @override
  List<Object?> get props => [smsCode];
}
