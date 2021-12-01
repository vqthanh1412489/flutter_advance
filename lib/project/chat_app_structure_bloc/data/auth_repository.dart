import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/models/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser?> getAuthUser();
  Future<AuthUser?> signIn();
  Future<void> logout();
}
