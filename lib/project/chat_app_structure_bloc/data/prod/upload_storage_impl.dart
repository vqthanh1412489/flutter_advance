import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/upload_storage_repository.dart';

class UploadStorageImpl extends UploadStorageRepository {
  @override
  Future<String> uploadPhoto(File file, String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final uploadTask = ref.putFile(file);
    await uploadTask;
    return await ref.getDownloadURL();
  }
}
