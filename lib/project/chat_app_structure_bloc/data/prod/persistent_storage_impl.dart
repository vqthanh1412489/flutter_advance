import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/persistent_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _keyDarkMode = 'IS_DATRK_MODE';

class PersistentStorageImpl extends PersistentStorageRepository {
  @override
  Future<bool> isDarkMode() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_keyDarkMode) ?? false;
  }

  @override
  Future<void> updateIsDarkMode(bool isDark) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    await sharedPreferences.setBool(_keyDarkMode, isDark);
    return;
  }
}
