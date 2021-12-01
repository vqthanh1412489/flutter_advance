import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/persistent_storage_repository.dart';

class PersistentStorageImpl extends PersistentStorageRepository {
  @override
  Future<bool> isDarkMode() async {
    // get to localstorage
    // await Future.delayed(const Duration(seconds: 1));
    return false;
  }

  @override
  Future<void> updateIsDarkMode(bool isDark) async {
    // save to localstorage
    // await Future.delayed(const Duration(seconds: 1));
    return;
  }
}
