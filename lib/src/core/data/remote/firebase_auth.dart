import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


abstract class FirebaseAuthCore {
  Future<User?> getCurrentUser();
  Future<UserCredential> signInWithGoogle();
  Future<void> signInWithFacebook();
  Future<void> signInWithPhoneNumber({
    BuildContext? context,
    required String phoneNumber,
  });
  Future<UserCredential> validateOtp({required String smsCode});
  Future<UserCredential?> linkPhoneNumberValidateOtp({required String smsCode});
  Future<void> signOut();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

class FirebaseAuthCoreImpl implements FirebaseAuthCore {
  FirebaseAuthCoreImpl({required this.firebaseAuth});

  final FirebaseAuth firebaseAuth;
  String? _verificationId;
  int? _resendToken;

  // ----------------   Current User Impl  ------------------
  @override
  Future<User?> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await signInWithCredential(credential: authCredential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithPhoneNumber({
    BuildContext? context,
    String? phoneNumber,
  }) async {
    final authPhoneNumber = phoneNumber;
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: authPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) async {
        if (e.code == 'invalid-phone-number') {
          // showTopSnackBar(
          //   Overlay.of(context!),
          //   const CustomSnackBar.error(
          //     message: 'Предоставленный номер телефона недействителен',
          //   ),
          // );
        } else if (e.code == 'too-many-requests') {
          // showTopSnackBar(
          //   Overlay.of(context!),
          //   const CustomSnackBar.error(
          //     message:
          //         'Мы заблокировали из-за необычной активности. Попробуйте позже.',
          //   ),
          // );
        } else {
          // showTopSnackBar(
          //   Overlay.of(context!),
          //   const CustomSnackBar.error(
          //     message: 'Что-то пошло не так. Пожалуйста, попытайтесь еще раз',
          //   ),
          // );
        }
      },
      codeSent: (String? verificationId, int? resendToken) async {
        _verificationId = verificationId;
        _resendToken = resendToken;
        log('codeSent');
        // showTopSnackBar(
        //   Overlay.of(context!),
        //   const CustomSnackBar.error(
        //     message: 'Код отправлен. Пожалуйста, проверьте свои сообщения.',
        //   ),
        // );
      },
      forceResendingToken: _resendToken,
      timeout: const Duration(seconds: 120),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }

  @override
  Future<UserCredential> validateOtp({
    required String? smsCode,
  }) async {
    try {
      final authCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: smsCode!);
      return await signInWithCredential(credential: authCredential);
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserCredential?> linkPhoneNumberValidateOtp({
    required String smsCode,
  }) async {
    try {
      final authCred = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: smsCode);
      final userCredential = await linkWithCredential(credential: authCred);
      return await reauthenticateWithCredential(credential: userCredential);
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCredential?> linkWithCredential({required credential}) async {
    try {
      final userCredential =
          await firebaseAuth.currentUser?.linkWithCredential(credential);
      return userCredential!;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          print("The provider has already been linked to the user.");
          break;
        case "invalid-credential":
          print("The provider's credential is not valid.");
          break;
        case "credential-already-in-use":
          print("The account corresponding to the credential already exists, "
              "or is already linked to a Firebase User.");
          break;
        // See the API reference for the full list of error codes.
        default:
          print("Unknown error.");
      }
      return null;
    }
  }

  Future<UserCredential> signInWithCredential({
    required AuthCredential credential,
  }) async {
    try {
      // User? result = firebaseAuth.currentUser;
      return await firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCredential?> reauthenticateWithCredential(
      {required credential}) async {
    try {
      return await firebaseAuth.currentUser!
          .reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }
}
