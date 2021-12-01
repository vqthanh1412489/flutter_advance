import 'dart:io';

import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/image_picker_auth_repository.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerImpl extends ImagePickerRepository {
  @override
  Future<File?> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickerFile =
          await picker.pickImage(source: ImageSource.gallery, maxWidth: 400);
      if (pickerFile != null) {
        return File(pickerFile.path);
      }
    } catch (ex) {
      return null;
    }
  }
}
