import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/image_picker_auth_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/usecases/group_usercase.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/home/selection/friend_selection_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class GroupSelectionState {
  final File? file;
  final Channel? channel;

  GroupSelectionState({this.file, this.channel});
}

class GroupSelectionCubit extends Cubit<GroupSelectionState> {
  GroupSelectionCubit(
      this.members, this._createGroupUseCase, this._imagePickerRepository)
      : super(GroupSelectionState());

  final CreateGroupUseCase _createGroupUseCase;
  final ImagePickerRepository _imagePickerRepository;

  final groupNameController = TextEditingController();
  final List<ChatUserState> members;

  Future<void> createGroup() async {
    if (state.file != null) {
      final channel = await _createGroupUseCase.createGroup(CreateGroupInput(
          state.file!,
          groupNameController.text,
          members.map((e) => e.chatUser.id).toList()));
      emit(GroupSelectionState(file: state.file, channel: channel));
    }
  }

  Future<void> pickImage() async {
    final image = await _imagePickerRepository.pickImage();
    emit(GroupSelectionState(file: image));
  }
}
