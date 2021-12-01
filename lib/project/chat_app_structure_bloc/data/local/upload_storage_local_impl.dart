import 'dart:io';

import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/upload_storage_repository.dart';

class UploadStorageImpl extends UploadStorageRepository {
  @override
  Future<String> uploadPhoto(File file, String path) async {
    // Connect firebase upload image
    return 'https://www.pngfind.com/pngs/m/111-1117759_girl-png-editing-girl-png-hd-transparent-png.png';
  }
}
