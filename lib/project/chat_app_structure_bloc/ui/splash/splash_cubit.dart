import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/exceptions/auth_exception.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashState {
  none,
  existing_user,
  verify_user,
}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.loginUseCase) : super(SplashState.none);

  LoginUseCase loginUseCase;

  Future<void> init() async {
    try {
      var result = await loginUseCase.validateLogin();
      if (result) {
        emit(SplashState.existing_user);
      }
    } on AuthException catch (ex) {
      if (ex.error == AuthErrorCode.not_auth) {
        emit(SplashState.none);
      } else {
        emit(SplashState.verify_user);
      }
    }
  }
}
