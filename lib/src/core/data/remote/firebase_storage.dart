import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseStorageCore {
  Future<String> uploadImages({
    required String collectionName,
    required String filePath,
    required String fileName,
  });
  Future<List<String>> getImagesUrl({
    required String collectionName,
  });
}

class FirebaseStorageCoreImpl implements FirebaseStorageCore {
  final FirebaseStorage fbStorage;

  FirebaseStorageCoreImpl({required this.fbStorage});

  @override
  Future<String> uploadImages({
    required String collectionName,
    required String filePath,
    required String fileName,
  }) async {
    File file = File(filePath);

    log('filePath ==> $filePath');
    log('fileName ==> $fileName');

    try {
      final uploadedFile =
          await fbStorage.ref('$collectionName/$fileName').putFile(file);

      final im = await uploadedFile.ref.getDownloadURL();
      //log(_im);

      return im;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<String>> getImagesUrl({
    required String collectionName,
  }) async {
    List<String> imagesLIst = [];

    try {
      final imageUrl = await fbStorage.ref(collectionName).listAll();
      for (var item in imageUrl.items) {
        // The items under storageRef.
        final url = await item.getDownloadURL();
        imagesLIst.add(url);
      }

      return imagesLIst;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }
}
