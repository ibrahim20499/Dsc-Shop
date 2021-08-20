import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class CloudStorage {
  static UploadTask? uploadImage(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } catch (e) {
      print(e);
    }
  }
}
