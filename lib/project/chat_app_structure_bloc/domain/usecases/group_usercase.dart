import 'dart:io';

import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/auth_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/stream_api_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/upload_storage_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/models/chat_user.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class CreateGroupInput {
  final File imageFile;
  final String name;
  final List<String> members;

  CreateGroupInput(this.imageFile, this.name, this.members);
}

class CreateGroupUseCase {
  CreateGroupUseCase(this._streamApiRepository, this._authRepository,
      this._uploadStorageRepository);

  final StreamApiRepository _streamApiRepository;
  final AuthRepository _authRepository;
  final UploadStorageRepository _uploadStorageRepository;

  Future<Channel> createGroup(CreateGroupInput createGroupInput) async {
    // final token = await _streamApiRepository.getToken(auth.id);
    final image = await _uploadStorageRepository.uploadPhoto(
        createGroupInput.imageFile, 'groups/${createGroupInput.name}');

    return await _streamApiRepository.createGroupChat(
        createGroupInput.name, createGroupInput.name, createGroupInput.members,
        image: image);
  }
}
