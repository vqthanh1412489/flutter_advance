import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/auth_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/image_picker_auth_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/prod/auth_impl.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/prod/image_picker_auth_impl.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/prod/persistent_storage_impl.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/prod/stream_api_impl.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/prod/upload_storage_impl.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/persistent_storage_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/stream_api_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/upload_storage_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/usecases/group_usercase.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/usecases/login_usecase.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/usecases/logout_usecase.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/usecases/profile_sign_in_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

List<RepositoryProvider> buildRepositories(StreamChatClient client) {
  return [
    RepositoryProvider<StreamApiRepository>(
        create: (_) => StreamApiImpl(client)),
    RepositoryProvider<PersistentStorageRepository>(
        create: (_) => PersistentStorageImpl()),
    RepositoryProvider<AuthRepository>(create: (_) => AuthLocalImpl()),
    RepositoryProvider<UploadStorageRepository>(
        create: (_) => UploadStorageImpl()),
    RepositoryProvider<ImagePickerRepository>(create: (_) => ImagePickerImpl()),
    RepositoryProvider<LoginUseCase>(
        create: (context) => LoginUseCase(context.read(), context.read())),
    RepositoryProvider<ProfileSignInUseCase>(
        create: (context) => ProfileSignInUseCase(
            context.read(), context.read(), context.read())),
    RepositoryProvider<LogoutUseCase>(
        create: (context) => LogoutUseCase(context.read(), context.read())),
    RepositoryProvider<CreateGroupUseCase>(
        create: (context) =>
            CreateGroupUseCase(context.read(), context.read(), context.read())),
  ];
}
