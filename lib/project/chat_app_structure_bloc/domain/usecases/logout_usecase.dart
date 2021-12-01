import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/auth_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/stream_api_repository.dart';

class LogoutUseCase {
  final AuthRepository authRepository;
  final StreamApiRepository streamApiRepository;

  LogoutUseCase(this.authRepository, this.streamApiRepository);

  Future<void> logout() async {
    await authRepository.logout();
    await streamApiRepository.logout();
  }
}
