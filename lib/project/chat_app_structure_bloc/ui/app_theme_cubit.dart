import 'package:flutter_advance_widget/project/chat_app_structure_bloc/data/persistent_storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeCubit extends Cubit<bool> {
  AppThemeCubit(this._persistentStorageRepository) : super(false);

  final PersistentStorageRepository _persistentStorageRepository;

  bool _isDark = false;

  bool get isDart => _isDark;

  Future<void> init() async {
    _isDark = await _persistentStorageRepository.isDarkMode();
    emit(_isDark);
  }

  Future<void> updateTheme(bool isDark) async {
    _isDark = isDark;
    await _persistentStorageRepository.updateIsDarkMode(isDark);
    emit(_isDark);
  }
}
