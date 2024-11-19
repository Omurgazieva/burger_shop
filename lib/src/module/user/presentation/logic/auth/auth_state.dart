part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class UnAuthenticatedState extends AuthState {}

class AuthenticatedState extends AuthState {
  final UserEntity user;
  const AuthenticatedState(this.user);
  @override
  List<Object> get props => [user];
}

class OtpVerificationState extends AuthState {
  final String phoneNumber;
  const OtpVerificationState(this.phoneNumber);
  @override
  List<Object> get props => [phoneNumber];
}

class LinkOtpVerificationState extends AuthState {
  final String phoneNumber;
  const LinkOtpVerificationState(this.phoneNumber);
  @override
  List<Object> get props => [phoneNumber];
}

class AuthFailureState extends AuthState {
  final ServerFailure error;
  const AuthFailureState(this.error);
  @override
  List<Object> get props => [error];
}
