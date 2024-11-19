part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class GetCurrentUserEvent extends AuthEvent {}

class SignInWithPhoneNumberEvent extends AuthEvent {
  final String phoneNumber;
  final BuildContext context;

  const SignInWithPhoneNumberEvent(this.phoneNumber, this.context);

  @override
  List<Object> get props => [phoneNumber, context];
}

class SendSmsCodeEvent extends AuthEvent {
  final String smsCode;

  const SendSmsCodeEvent(this.smsCode);

  @override
  List<Object> get props => [smsCode];
}

class SignInWithGoogleEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

class CancelEvent extends AuthEvent {}
