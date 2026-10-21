import 'package:url_launcher/url_launcher.dart';

abstract final class LinkService {
  static Future<bool> open(Uri uri) async {
    if (uri.scheme != 'https' && uri.scheme != 'http') return false;
    try {
      return await launchUrl(uri, webOnlyWindowName: '_blank');
    } catch (_) {
      return false;
    }
  }
}
