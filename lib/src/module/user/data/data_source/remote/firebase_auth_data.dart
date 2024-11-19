import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../user.dart';

abstract class FirebaseAutData {
  // CurrentUser
  Future<UserModel?> getCurrentUser();

  Future<void> signInWithPhoneNumber({
    BuildContext? context,
    required String phoneNumber,
  });

  Future<UserCredential> validateOtp({required String smsCode});

  Future<bool> checkUserExistsFromForestore({required String userId});

  Future<UserModel> getUserFromForestore({required String userId});

  Future<bool?> createUserToFirestore({required User user});

  Future<UserModel> signInWithGoogle();

  Future<UserModel?> signInWithFacebook();

  // Sign Out
  Future<bool> signOut();
}

class FirebaseAuthImpl implements FirebaseAutData {
  FirebaseAuthImpl({required this.firebaseAuth, required this.firestore});

  final FirebaseAuthCore firebaseAuth;
  final FirestoreCore firestore;

  // CurrentUser
  @override
  Future<UserModel?> getCurrentUser() async {
    final userFromServer = await firebaseAuth.getCurrentUser();
    if (userFromServer != null) {
      final isUserExists =
          await checkUserExistsFromForestore(userId: userFromServer.uid);
      if (isUserExists) {
        final currentUser =
            await getUserFromForestore(userId: userFromServer.uid);
        return currentUser;
      }
    }
    return null;
  }

  @override
  Future<void> signInWithPhoneNumber({
    BuildContext? context,
    String? phoneNumber,
  }) async {
    return firebaseAuth.signInWithPhoneNumber(
      context: context,
      phoneNumber: phoneNumber!,
    );
  }

  @override
  Future<UserCredential> validateOtp({
    String? smsCode,
  }) async {
    return await firebaseAuth.validateOtp(smsCode: smsCode!);
  }

  // Sign In
  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final currentUser = await firebaseAuth.signInWithGoogle();
      final isUserExists = await checkUserExistsFromForestore(
        userId: currentUser.user!.uid,
      );
      if (!isUserExists) {
        await createUserToFirestore(user: currentUser.user!);
      }
      return await getUserFromForestore(
        userId: currentUser.user!.uid,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  // Sign Out
  @override
  Future<bool> signOut() async {
    await firebaseAuth.signOut();
    return true;
  }

  @override
  Future<bool> checkUserExistsFromForestore({required String userId}) async {
    return firestore.checkDocExists(
      docId: userId,
      collectionName: 'users',
    );
  }

  @override
  Future<UserModel> getUserFromForestore({required String userId}) async {
    return firestore.get(
      docId: userId,
      collectionName: 'users',
      fromJson: authFromJson,
    );
  }

  @override
  Future<bool> createUserToFirestore({required User user}) async {
    final currentUser = UserModel(
      userID: user.uid,
      email: user.email,
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      orders: const [],
      shippingAddresses: const [],
      paymentMethods: const [],
      photoURL: user.photoURL,
    );
    return await firestore.create(
      docId: currentUser.userID!,
      objectModel: currentUser,
      collectionName: 'users',
    );
  }
}
