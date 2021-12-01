import 'package:flutter_advance_widget/project/chat_app_structure_bloc/domain/usecases/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingSwichCubut extends Cubit<bool> {
  SettingSwichCubut(bool state) : super(state);

  void onChangeDarkMode(bool isDark) => emit(isDark);
}

class SettingLogoutCubut extends Cubit<void> {
  SettingLogoutCubut(this.logoutUseCase) : super(null);

  final LogoutUseCase logoutUseCase;

  Future<void> onLogout() async {
    await logoutUseCase.logout();
    emit(null);
  }
}
