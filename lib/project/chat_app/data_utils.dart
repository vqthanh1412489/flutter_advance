abstract class DataUtils {
  static String getUserImage(String username) {
    if (username == 'thanh') {
      return '';
    }

    return _getImageFromUrl(username);
  }

  static String getChannelImage() => _getImageFromUrl('');

  static String _getImageFromUrl(String value) =>
      'https://ui-avatars.com/api/?name=$value&background=random';
}
