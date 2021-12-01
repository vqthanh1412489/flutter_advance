import 'dart:io';

import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/auth_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/stream_api_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/upload_storage_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/models/chat_user.dart';

class ProfileInput {
  final File imageFile;
  final String name;

  ProfileInput({required this.imageFile, required this.name});
}

class ProfileSignInUseCase {
  ProfileSignInUseCase(this._streamApiRepository, this._authRepository,
      this._uploadStorageRepository);

  final StreamApiRepository _streamApiRepository;
  final AuthRepository _authRepository;
  final UploadStorageRepository _uploadStorageRepository;

  Future<void> signInUser(ProfileInput profileInput) async {
    final auth = await _authRepository.getAuthUser();
    if (auth != null) {
      final token = await _streamApiRepository.getToken(auth.id);
      final image = await _uploadStorageRepository.uploadPhoto(
          profileInput.imageFile, 'users/${auth.id}');

      await _streamApiRepository.connectUser(
          ChatUser(name: profileInput.name, image: image, id: auth.id), token);
    }
  }
}
