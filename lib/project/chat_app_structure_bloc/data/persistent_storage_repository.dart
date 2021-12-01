abstract class PersistentStorageRepository {
  Future<bool> isDarkMode();
  Future<void> updateIsDarkMode(bool isDark);
}
