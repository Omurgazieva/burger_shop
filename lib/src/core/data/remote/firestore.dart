import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreCore {
  // Check
  Future<bool> checkDocExists({
    required String docId,
    required String collectionName,
  });

  // Get Id
  Future<String> getId({
    required String collectionName,
  });

  // Get
  Future<T> get<T>({
    required String docId,
    required String collectionName,
    required T Function(Map body) fromJson,
  });
  Future<List<T>> getList<T>({
    required String collectionName,
    required T Function(Map<String, dynamic> body) fromJson,
  });

  // Post
  Future<bool> create({
    required String docId,
    required objectModel,
    required String collectionName,
  });

  //Update
  Future<bool> update({
    required String docId,
    required objectModel,
    required String collectionName,
  });
}

// ------------------------------------------------------------------------------------------

class FirestoreCoreImpl implements FirestoreCore {
  final FirebaseFirestore firestoreDB;

  FirestoreCoreImpl({required this.firestoreDB});

  // Check
  @override
  Future<bool> checkDocExists({
    required String docId,
    required String collectionName,
  }) async {
    DocumentSnapshot doc =
        await firestoreDB.collection(collectionName).doc(docId).get();
    return doc.exists;
  }

  // Get id
  @override
  Future<String> getId({
    required String collectionName,
  }) async {
    return firestoreDB.collection(collectionName).doc().id;
  }

  //------- Get ----------------------------------------------------------------------------------------
  @override
  Future<T> get<T>({
    required String docId,
    required String collectionName,
    required T Function(Map body) fromJson,
  }) async {
    DocumentSnapshot response =
        await firestoreDB.collection(collectionName).doc(docId).get();
    final docMap = response.data() as Map<String, dynamic>;
    return fromJson(docMap);
  }

  @override
  Future<List<T>> getList<T>({
    required String collectionName,
    required T Function(Map<String, dynamic> body) fromJson,
  }) async {
    List<T> list = <T>[];
    final response = await firestoreDB.collection(collectionName).get();
    for (final doc in response.docs) {
      final object = fromJson(doc.data());
      list.add(object);
    }
    return list;
  }

  // ----- Post ---------------------------------------------------------------------------------
  @override
  Future<bool> create({
    required String docId,
    required objectModel,
    required String collectionName,
  }) async {
    return await firestoreDB
        .collection(collectionName)
        .doc(docId)
        .get()
        .then((doc) {
      final newObject = objectModel.toJson();
      if (!doc.exists) {
        firestoreDB
            .collection(collectionName)
            .doc(docId)
            .set(newObject, SetOptions(merge: true));
      }
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  // -----  Update  --------------------------------------------------------------
  @override
  Future<bool> update({
    required String docId,
    required objectModel,
    required String collectionName,
  }) async {
    log('objectModel ===>> $objectModel');
    return await firestoreDB
        .collection(collectionName)
        .doc(docId)
        .get()
        .then((doc) {
      final newObjectModel = objectModel.toJson();
      //log('newObjectModel ===>> ${objectModel.toJson()}');
      if (doc.exists) {
        firestoreDB
            .collection(collectionName)
            .doc(docId)
            .update(newObjectModel);
      }

      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }
}
