import 'package:url_launcher/url_launcher.dart';

extension EmailLauncher on String {
  void launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: this,
    );

    if (await canLaunchUrl(
      Uri.parse(
        emailLaunchUri.toString(),
      ),
    )) {
      await launchUrl(
        Uri.parse(
          emailLaunchUri.toString(),
        ),
      );
    } else {
      throw 'Could not launch email';
    }
  }
}
