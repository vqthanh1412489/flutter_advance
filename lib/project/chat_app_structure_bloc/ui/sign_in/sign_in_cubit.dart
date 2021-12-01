import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

enum SigninState {
  none,
  existing_user,
}

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.loginUseCase) : super(SigninState.none);

  final LoginUseCase loginUseCase;

  Future<void> onSignIn() async {
    try {
      final result = await loginUseCase.validateLogin();
      if (result) {
        emit(SigninState.existing_user);
      }
    } catch (ex) {
      final result = await loginUseCase.signIn();
      if (result != null) {
        emit(SigninState.none);
      }
    }
  }
}
