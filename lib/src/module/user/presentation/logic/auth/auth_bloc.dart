import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUser getCurrentUser;
  final SignInWithPhoneNumber signInWithPhoneNumber;
  final SendSmsCode sendSmsCode;
  final SignInWithGoogle signInWithGoogle;
  final SignOut signOut;

  AuthBloc({
    required this.getCurrentUser,
    required this.signInWithPhoneNumber,
    required this.sendSmsCode,
    required this.signInWithGoogle,
    required this.signOut,
  }) : super(UnAuthenticatedState()) {
    on<GetCurrentUserEvent>(_getCurrentUser);
    on<SignInWithPhoneNumberEvent>(_signInWithPhoneNumber);
    on<SendSmsCodeEvent>(_sendSmsCode);
    on<SignInWithGoogleEvent>(_signInWithGoogle);
    on<SignOutEvent>(_signOut);
    on<CancelEvent>(_cancel);
  }

  void _cancel(CancelEvent event, Emitter<AuthState> emit) {
    emit(UnAuthenticatedState());
  }

  void _getCurrentUser(
    GetCurrentUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final currentUser = await getCurrentUser.getCurrentUser();
    currentUser.fold(
      (error) => emit(AuthFailureState(error as ServerFailure)),
      (user) {
        if (user != null) {
          emit(AuthenticatedState(user));
        } else {
          emit(UnAuthenticatedState());
        }
      },
    );
  }

  void _signInWithPhoneNumber(
      SignInWithPhoneNumberEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final signIn = await signInWithPhoneNumber(
      SignInWithPhoneNumberParams(
        phoneNumber: event.phoneNumber,
        context: event.context,
      ),
    );
    signIn.fold(
      (error) => emit(AuthFailureState(error as ServerFailure)),
      (sendSmsCode) => emit(OtpVerificationState(event.phoneNumber)),
    );
  }

  void _sendSmsCode(SendSmsCodeEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final currentUser = await sendSmsCode(
      SmsCodeParams(smsCode: event.smsCode),
    );
    currentUser.fold(
      (error) => emit(AuthFailureState(error as ServerFailure)),
      (user) => emit(AuthenticatedState(user)),
    );
  }

  void _signInWithGoogle(
      SignInWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final user = await signInWithGoogle.signInWithGoogle();
    user.fold(
      (error) => emit(AuthFailureState(error as ServerFailure)),
      (user) => emit(AuthenticatedState(user)),
    );
  }

  void _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final isSignedOut = await signOut.signOut();
    isSignedOut.fold(
      (error) => emit(AuthFailureState(error as ServerFailure)),
      (isSignedOut) {
        if (isSignedOut!) {
          emit(UnAuthenticatedState());
        }
      },
    );
  }
}
