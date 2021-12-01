import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/auth_repository.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/models/auth_user.dart';

class AuthLocalImpl extends AuthRepository {
  @override
  Future<AuthUser?> getAuthUser() async {
    await Future.delayed(const Duration(seconds: 1));
    return AuthUser('vqthanh1412489');
  }

  @override
  Future<void> logout() async {
    return;
  }

  @override
  Future<AuthUser> signIn() async {
    await Future.delayed(const Duration(seconds: 1));
    return AuthUser('vqthanh1412489');
  }
}
