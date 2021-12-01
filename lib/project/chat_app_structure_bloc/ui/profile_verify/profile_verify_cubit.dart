import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/image_picker_auth_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/usecases/profile_sign_in_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileVerifyState {
  const ProfileVerifyState({this.file, this.success = false});

  final File? file;
  final bool success;
}

class ProfileVerifyCubit extends Cubit<ProfileVerifyState> {
  ProfileVerifyCubit(this._imagePickerRepository, this._profileSignInUseCase)
      : super(const ProfileVerifyState());

  final ImagePickerRepository _imagePickerRepository;
  final ProfileSignInUseCase _profileSignInUseCase;

  final nameController = TextEditingController();

  Future<void> startChatting() async {
    final file = state.file;
    if (file != null) {
      final name = nameController.text;
      await _profileSignInUseCase
          .signInUser(ProfileInput(imageFile: file, name: name));

      emit(ProfileVerifyState(file: file, success: true));
    }
  }

  Future<void> pickImage() async {
    final file = await _imagePickerRepository.pickImage();
    if (file != null) {
      emit(ProfileVerifyState(file: file));
    }
  }
}
